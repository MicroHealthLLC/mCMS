class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  acts_as_paranoid

  # ldap_authenticatable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :lockable, :omniauthable,
         :password_expirable, :password_archivable,
         :session_limitable, :expirable, :secure_validatable

  # HAS ONE
  has_one :core_demographic
  accepts_nested_attributes_for :core_demographic

  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_one :user_extend_demography
  has_one :job_detail
  accepts_nested_attributes_for :job_detail
  belongs_to :role, optional: true

  # HAS MANY FOR PROFILE
  has_many :affiliations, dependent: :destroy
  has_many :certifications, dependent: :destroy
  has_many :clearances, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :other_skills, dependent: :destroy
  has_many :languages, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :positions, dependent: :destroy
  has_many :user_insurances, dependent: :destroy
  has_many :jsignatures, as: :signature_owner, dependent: :destroy


  #HAS MANY FO CASES
  has_many :documents, dependent: :destroy
  has_many :related_clients, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :organizations, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :cases, dependent: :destroy
  has_many :case_supports, dependent: :destroy
  has_many :needs, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :project_users, class_name: 'Kanban::ProjectUser'
  has_many :projects, through: :project_users, class_name: 'Kanban::Project'

  has_many :tasks, dependent: :destroy
  has_many :assigned_tasks, class_name: 'Task', foreign_key: :assigned_to_id
  has_many :checklist_answers, dependent: :destroy


  has_many :user_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :user_attachments, reject_if: :all_blank, allow_destroy: true

  has_many :document_managers, dependent: :destroy
  has_many :revisions, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships

  STATUS = [['Active', true],['Inactive', false]]

  def member_of(group_id)
    # check if user is a member of specific group
    memberships.each do |membership|
      if membership.group_id == group_id
        return true
      end
    end
    return false
  end

  def timeout_in
    if last_seen_at < 10.months.ago
      1.second
    else
      super
    end
  end

  def writable_categories
    categories = []
    Category.all.each do |category|
      # check if category is private or unwritable
      if !category.is_writable or category.is_private
        # if user is a member of the controlling group
        #  they have permission to upload to the private / unwritable category
        if member_of(category.group_id)
          categories << category
        end
      else
        # No restrictions on this group, anyone can upload
        #  as long as they are logged in
        categories << category
      end
    end
    return categories.sort! { |a,b| a.name.downcase <=> b.name.downcase }
  end



  before_create do
    self.ldap_authenticatable= '' if self.ldap_authenticatable.to_s.blank?
  end

  after_update :check_status

  validates_uniqueness_of :login, :email
  validates_presence_of :login, :email


  def self.include_enumerations
    includes(:role, :core_demographic=> :gender_type).
        references(:role, :core_demographic=> :gender_type)
  end

  def check_status
    return if self.anonyme_user?
    UserMailer.account_activated(self).deliver_later if self.account_active? and self.state_was == false
  end

  def self.user_deleted?(auth)
    user = get_user(auth)
    return user.deleted? if user
    false
  end

  def organization
    job_detail.try(:organization)
  end

  def self.get_user(auth)
    unscoped.where(provider: auth.provider, uid: auth.uid).or(User.unscoped.where(email: auth.info.email || "#{auth.uid}@#{auth.provider}.com")).first
  end

  def self.from_omniauth(auth)
    if where(email: auth.info.email || "#{auth.uid}@#{auth.provider}.com").present?
      return where(email: auth.info.email || "#{auth.uid}@#{auth.provider}.com").first
    end
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email || "#{auth.uid}@#{auth.provider}.com"
      user.login = auth.info.email || "#{auth.uid}@#{auth.provider}.com"
      user.password = Devise.friendly_token[0,20]
      user.ldap_authenticatable= '',
          user.state = Setting['user_default_state']
    end
  end

  def self.create_with_jwt_hash(jwt)
    email = jwt['email'].presence || jwt['preferred_username']
    where(provider: 'office365', uid: email).first_or_create do |user|
      user.provider = 'office365'
      user.uid = email
      user.email = email
      user.login = jwt['name']
      user.password = Devise.friendly_token[0,20]
      user.ldap_authenticatable= ''
    end
  end

  def username
    login
  end

  def addresses
    return [] if user_extend_demography.nil?
    Address.where(extend_demography: user_extend_demography.id)
  end

  def phone
    return Phone.new if user_extend_demography.nil?
    user_extend_demography.phones.first || Phone.new
  end

  def principal_role
    return 'Admin' if admin?
    role.try(:role_type) || 'No role defined'
  end

  def self.visible
    if User.current.allowed_to?(:manage_roles)
      employees
    else
      where(id: User.current.id)
    end
  end

  def visible
    if allowed_to?(:manage_roles)
      User.where(nil)
    else
      User.where(id: User.current.id)
    end
  end

  def self.employees
    r = Role.pluck(:id) - Role.where("permissions like ?", "%manage_roles%").pluck(:id)
    r<< nil
    User.where(admin: false).where(role_id: r)
  end

  def self.power_user
    r = Role.where("permissions like ?", "%manage_roles%").pluck(:id)
    if r.present?
      User.where(admin: true).or(User.where(role_id: r))
    else
      User.where(admin: true)
    end
  end

  def has_unread_message(receiver)
    chat_room = ChatRoom.where(user_id: self.id).where(receiver_id: receiver.id).or(ChatRoom.where(user_id: receiver.id).where(receiver_id: self.id)).first
    unless chat_room.message_seen?
      if chat_room.messages.last.user_id != self.id
        chat_room.messages.last.body
      end
    end
  end

  def self.current=(user)
    RequestStore.store[:current_user] = user
  end

  def self.current
    RequestStore.store[:current_user] ||= User.new
  end

  def self.current_user=(user)
    RequestStore.store[:user] = user
  end

  def self.current_user
    RequestStore.store[:user] ||= User.new
  end

  def checklist_template_answers(template_id)
    checklist_answers.where(checklist_template_id: template_id)
  end

  def extend_informations
    user_extend_demography || UserExtendDemography.new(user_id: self.id)
  end

  def can?(*args)
    args.map{|action| allowed_to? action }.include?(true)
  end

  def allowed_to?(action)
    if action.is_a? Hash
      allowed_actions.include? "#{action[:controller]}/#{action[:action]}"
    else
      permissions.include? action.to_sym
    end
  end

  def has_same_department?(for_user)
    permitted_users.include?(for_user)
  end

  def permitted_users
    @permitted_users ||= begin
      if self.admin?
        User.where(nil)
      elsif !job_detail
        User.where(id: self.id)
      else
        job_detail.department.users
      end
    end
  end

  def all_permissions
    @allowed_permissions ||= begin
      RedCarpet::AccessControl.permissions.collect {|p| p.name}.to_set
    end
  end

  def allowed_actions
    @actions_allowed ||= permissions.inject([]) { |actions, permission| actions += RedCarpet::AccessControl.allowed_actions(permission) }.flatten
  end


  def job
    job_detail || JobDetail.new(user_id: self.id)
  end

  def name
    cd = core_demographic
    return login if cd.nil?
    "#{cd.first_name} #{cd.last_name}"
  end

  def profile
    @profile ||= begin
      core_demographic || CoreDemographic.new(user_id: self.id)
    end
  end

  def first_name;  profile.first_name;  end
  def middle_name; profile.middle_name; end
  def last_name;   profile.last_name;   end
  def user_title;  profile.title;   end
  def full_name;   name;   end
  def birthday;    profile.birth_date;  end
  def religion;    profile.religion_type;  end
  def ethnicity;   profile.ethnicity_type;  end
  def citizenship; profile.citizenship_type;  end
  def gender;      profile.gender;      end
  def active?;     self.state ? 'Active' : 'Non active';         end

  def profile_name
    "#{first_name} #{middle_name} #{last_name}".gsub('  ', ' ')
  end


  def profile_image
    if avatar.thumb.url
      avatar.thumb.url
    else
      'male.png'
    end
  end

  def self.safe_attributes
    [:login, :state, :email, :role_id]
  end

  def self.safe_attributes_with_password_with_core_demographic_without_state
    [:login, :email, :password, :password_confirmation,
     core_demographic_attributes: [CoreDemographic.safe_attributes]]
  end

  def self.safe_attributes_with_password
    [:login, :state, :email,
     :password, :password_confirmation, job_detail_attributes: [JobDetail.safe_attributes],
     core_demographic_attributes: [CoreDemographic.safe_attributes]]
  end

  def self.admin_safe_attributes
    [:login, :state, :email, :role_id,
     :password, :password_confirmation,
     :admin, job_detail_attributes: [JobDetail.safe_attributes],
     core_demographic_attributes: [CoreDemographic.safe_attributes]]
  end

  def active_for_authentication?
    # Uncomment the below debug statement to view the properties of the returned self model values.
    # logger.debug self.to_yaml

    super && account_active?
  end

  def account_active?; state?; end

  def to_s
    name
  end

  def permissions
    @user_permission ||= begin
      if self.admin?
        @user_permission = all_permissions
      elsif role
        @user_permission =  (role.try( :permissions ) || []).to_set
      else
        @user_permission = [].to_set
      end
    end
  end

  def role
    @user_role ||= begin
      super || Role.default
    end
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "User ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    if avatar_url
      pdf.table([[ {:image => "#{Rails.root}/public/#{avatar.resized.url}", :image_height => 100, :image_width => 100} ]], :column_widths => [ 523],  :cell_style=> {align: :center})
    end
    pdf.table([["User Information"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Login: ", " #{login}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Email: ", " #{email}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Active: ", " #{active?}"]], :column_widths => [ 150, 373])

    pdf.move_down 10
    pdf.table([["Profile Information"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})

    pdf.table([[ "Name: ", " #{profile_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Gender: ", " #{gender}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Birthday: ", " #{birthday}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Religion: ", " #{religion}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Ethnicity: ", " #{ethnicity}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Citizenship: ", " #{citizenship}"]], :column_widths => [ 150, 373])

    pdf.move_down 10
  end

  def to_pdf_organization(pdf)
    if job_detail
      org = job_detail.organization
      org.to_pdf_short_desc(pdf) if org
    end
  end

  def to_pdf_brief_info(pdf)
    data = []
    pdf.table([["Client Information"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    data << ["First Name", first_name]
    data << ["Middle Name", middle_name]
    data << ["Last Name", last_name]
    data << ["Birthday", "#{birthday}"]
    data << ["Gender", "#{gender}"]
    pdf.table(data, :column_widths => [ 150 , 373])
    pdf.move_down 10
  end

  def pivot_table
    {}
  end

  def self.recently_active
    where('last_seen_at > ?', 5.minutes.ago)
  end

  mount_uploader :avatar, AvatarUploader
end
