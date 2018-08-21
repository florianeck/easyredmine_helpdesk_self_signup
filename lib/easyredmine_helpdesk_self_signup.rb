module EasyredmineHelpdeskSelfSignup
  def self.cf_mail_id
    @@_CF_MAIL_ID ||= EasyContactCustomField.find_by_internal_name("easy_contacts_email").id
  end
  
  def self.cf_user_id
    @@_CF_USER_ID ||= EasyContactCustomField.find_by_internal_name("easy_contacts_user").id
  end
end

require "easyredmine_helpdesk_self_signup/user_extension"
require "easyredmine_helpdesk_self_signup/hooks"

Rails.application.config.after_initialize do
  User.send :include, EasyredmineHelpdeskSelfSignup::UserExtension
  EasyHelpdeskProject.safe_attributes 'self_signup_default_role', 'self_signup_easy_user_type_id'
end
