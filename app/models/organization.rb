class Organization < ApplicationRecord
  has_many :users
  belongs_to :user
  belongs_to :organization_type
  has_one :organization_extend_demography, :dependent => :destroy

  has_many :job_details

  has_many :organization_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :organization_attachments, reject_if: :all_blank, allow_destroy: true


  def visible?
    User.current == user or User.current.allowed_to?(:edit_organizations) or User.current.allowed_to?(:manage_organizations)
  end

  def organization_type
    if organization_type_id
      super
    else
      OrganizationType.default
    end
  end

  def grouped_by_role
    # the compact  function is made to get active user since some of them may be deleted
    job_details.map(&:user).compact.group_by{|u| u.principal_role }
  end

  def to_s
    name
  end

  def self.safe_attributes
    [:name, :organization_type_id, :note, :user_id ]
  end

  def extend_informations
    organization_extend_demography || OrganizationExtendDemography.new(organization_id: self.id)
  end


  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Organization ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    pdf.table([[ "Name ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Organization type ", " #{organization_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

  def address
    extend_demo = self.extend_informations
    if extend_demo.addresses.present?
      extend_demo.addresses.first
    else
      Address.new
    end
  end

  def phone
    extend_demo = self.extend_informations
    if extend_demo.phones.present?
      extend_demo.phones.first
    else
      Phone.new
    end
  end

  def to_pdf_short_desc(pdf)
    pdf.text "#{name}", :align => :center

    extend_demo = self.extend_informations
    if extend_demo
      if extend_demo.addresses.present?
        address = extend_demo.addresses.first
        pdf.text address.address,:align => :center if address.address.present?
        pdf.text address.second_address,:align => :center  if address.second_address.present?
        pdf.text "#{address.state_type}, #{address.city} #{address.zip_code}",:align => :center
      end
      if extend_demo.phones.present?
        phone = extend_demo.phones.first
        pdf.text phone.phone_number , :align => :center
      end
      if extend_demo.emails.present?
        email = extend_demo.emails.first
        pdf.text email.email_address, :align => :center
      end
      pdf.move_down 10
    end
  end

end
