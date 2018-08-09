module EasyredmineHelpdeskSelfSignup
  
end

require "easyredmine_helpdesk_self_signup/user_extension"
require "easyredmine_helpdesk_self_signup/hooks"

Rails.application.config.after_initialize do
  User.send :include, EasyredmineHelpdeskSelfSignup::UserExtension
  EasyHelpdeskProject.safe_attributes 'self_signup_default_role'
end
#
# ApplicationController.send :include, EasyredmineSipgateHelper
# ApplicationController.send :helper, :easyredmine_sipgate