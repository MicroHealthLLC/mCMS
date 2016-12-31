class UserMailer < ApplicationMailer
  def welcome_email(user, password= nil)
    @user = user
    @password = password
    mail(to: @user.email, subject: "Welcome to #{Setting['application_name']}")
  end

  def account_activated(user)
    @user = user
    mail(to: @user.email, subject: 'Account activated')
  end

  def affiliation_notification(object)
    @user = object.user
    @affiliation = object
    mail(to: @user.email, subject: "Affiliation ##{@affiliation.id}")
  end

  def certification_notification(object)
    @user = object.user
    @certification = object
    mail(to: @user.email, subject: "Certification ##{@certification.id}")
  end

  def clearance_notification(object)
    @user = object.user
    @clearance = object
    mail(to: @user.email, subject: "Clearance ##{@clearance.id}")
  end

  def contact_notification(object)
    @user = object.user
    @contact = object
    mail(to: @user.email, subject: "Contact ##{@contact.id}")
  end

  def document_notification(object)
    @user = object.user
    @document = object
    mail(to: @user.email, subject: "Document ##{@document.id}")
  end

  def education_notification(object)
    @user = object.user
    @education = object
    mail(to: @user.email, subject: "Education ##{@education.id}")
  end

  def new_notification(object)
    @user = object.user
    @object = object
    mail(to: @user.email, subject: "New ##{@object.id}")
  end

  def language_notification(object)
    @user = object.user
    @language = object
    mail(to: @user.email, subject: "Language ##{@language.id}")
  end

  def skill_notification(object)
    @user = object.user
    @skill = object
    mail(to: @user.email, subject: "Skill ##{@skill.id}")
  end

  def position_notification(object)
    @user = object.user
    @position = object
    mail(to: @user.email, subject: "Position ##{@position.id}")
  end

  def task_notification(object)
    @user = object.user
    @task = object
    mail(to: @user.email, subject: "Task ##{@task.id}")
  end
end
