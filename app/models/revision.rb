class Revision < ApplicationRecord

  belongs_to :document_manager
  belongs_to :user

  validates_presence_of :file_name, :file_type, :file_data

  def extension_type
    ext = case file_type
      # PDF Files
      when "application/pdf" then "pdf"
      when "application/msword" then "doc"
      when "application/vnd.oasis.opendocument.text" then "odt"
      else "other"
    end
    ext
  end

  def document
    document_manager
  end

  def extract_text
    # Create a temporary file to read from 
    tempfile = Tempfile.new(file_name, :encoding => 'ascii-8bit')
    tempfile.write(file_data)
    tempfile.close

    # Try extracting the contents of the file depending on the content type
    begin
      contents = Textractor.text_from_path(tempfile.path, :content_type => file_type)
    rescue
      logger.error("Unable to extract text from file. Revision id = #{id}, File name = #{file_name}")
      contents = nil
    end
    tempfile.unlink

    # Get rid of utf-8 control characters 
    contents.gsub!(/\P{ASCII}/, '') if !contents.blank?
    # Redundant line breaks are useless to us
    self.search_text = contents.gsub(/(\r?\n)+/,"\n") if !contents.blank?
  end

end
