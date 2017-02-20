class SpreadsheetEnumerationUpload
  attr_accessor :file, :extname, :invalid_file_parse

  FILE_EXTNAME = ['.csv', '.xls', '.xlsx']

  def initialize(file)
    @file         = file
  end

  def valid_file?
    original_filename = file.original_filename
    @extname = File.extname(original_filename)
    return true if FILE_EXTNAME.include?(@extname)
    false
  end

  def open_file
    original_filename = file.original_filename
    case File.extname(original_filename)
      when ".csv" then
        Roo::CSV.new(file.path, csv_options: {encoding: 'ISO-8859-1'})
      when ".xls" then
        Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then
        Roo::Excelx.new(file.path)
      else
        @invalid_file_parse = "Unknown file type: #{original_filename}"
    end
  end

  def upload_enumeration(e)
    roo_csv  = open_file
    sheet = roo_csv.sheet(0)
    parse_sheet(sheet) do  |row|
      e.where(name: row[0] ).first_or_create
    end
  end

  def upload_immunization_cvx
    roo_csv  = Roo::Excelx.new(file)
    sheet = roo_csv.sheet(0)
    parse_sheet(sheet) do  |row|
      params = {
          cvx_short_description: row[1],
          full_vaccine_name: row[2] ,
          note: row[3],
          vaccinestatus: row[4],
          internal_id: row[5],
          nonvaccine: row[6] ,
          update_date: row[7]
      }
      i = ImmunizationCvx.where(cvx_code: row[0] ).first_or_initialize
      i.update(params)
    end
  end

  def parse_sheet(sheet, &block)
    retries = true
    begin
      sheet.each_with_index do |row, idx|
        next if idx.zero?
        next if row[0..3].map(&:presence).compact.blank?
        yield row
      end
    rescue Exception => e
      # Try to extract the data
      if retries
        sheet, can_retry = get_sheet
        retries = false
        retry if can_retry
      end
      @invalid_file_parse = e.message == "invalid byte sequence in UTF-8" ? I18n.t("back_end.wrong_file") :  e.message
      Rollbar.critical("IMPORT DOC: #{e.message}, current_saas_company: #{@current_saas_company.id}, current_saas_office: #{@current_saas_office.id}, file: #{file} ")
      return @invalid_file_parse
    end
  end

  def get_sheet
    f = File.open(@file.tempfile, encoding: "ISO-8859-1")
    content = f.read
    files_rows = content.split(guess_returning_line(content))
    [change_rows(files_rows), true]
  rescue Exception => e
    [nil, false]
  end

  def guess_returning_line(content)
    content.count("\r") > content.count("\n") ? "\r" : "\n"
  end

  def change_rows(files_rows)
    separator =  guess_separator(files_rows.first)
    files_rows.map{|line | line.split(separator)}
  end

  def guess_separator(first_line)
    commas = first_line.count(",")
    semicolons = first_line.count(";")
    commas > semicolons ? ',' : ';'
  end

end
