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

  def little_description
    output = ''
    output<< "<p> Person name: #{person_name} </p>"
    output<< "<p> Signature: #{ActionController::Base.helpers.image_tag(signature.html_safe, size: '200x150')} </p>"

    output.html_safe
  end


  def to_pdf(pdf, name = 'Signature')
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

    pdf.table([[name]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Person Name: ", " #{person_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Owner: ", " #{signature_owner_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "", {image: "#{Rails.root}/#{image}", :image_height => 150, :image_width => 300}]], :column_widths => [ 150, 373])
    pdf.move_down(10)

  end
end
