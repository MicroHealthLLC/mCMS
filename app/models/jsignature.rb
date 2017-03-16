class Jsignature < ApplicationRecord
  belongs_to :user
  belongs_to :signature_owner, polymorphic: true

  validates_presence_of :user_id, :person_name, :signature

  def to_s
    person_name
  end

  def self.safe_attributes
    [:user_id, :person_name, :signature_owner_type, :signature_owner_id, :signature]
  end

  def to_pdf(pdf, show_user=true)
    path = "public/signature"
    unless File.directory?(path)
      FileUtils.mkdir_p(path)
    end
    image = path + "/signature_#{id}.png"
    unless FileTest.exist?(image)
      data_url = signature
      png      = Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
      File.open(image, 'wb') { |f| f.write(png) }
    end

    pdf.table([["User Information"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "person_name: ", " #{person_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Owner: ", " #{signature_owner_type}"]], :column_widths => [ 150, 373])
    pdf.move_down(10)
    pdf.image("#{Rails.root}/#{image}", width: 350, height:250, position: :center)
  end
end
