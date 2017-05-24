class EmailUpdateWorker
  include Sidekiq::Worker

  def perform(object_type, object_id)
    object = object_type.constantize.find(object_id)
    if object.can_send_email? && object.email_notification_enabled?('update')
      last_audit = Array.wrap(object.try(:audits)).last
      if last_audit
        UserMailer.send_update_notification(object, last_audit).deliver_now
      else
        UserMailer.send_notification(object).deliver_now
      end
    end
  end
end
