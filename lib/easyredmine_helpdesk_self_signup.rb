module EasyredmineHelpdeskSelfSignup
  
end

require "easyredmine_helpdesk_self_signup/user_extension"

Rails.application.config.after_initialize do
  User.send :include, EasyredmineHelpdeskSelfSignup::UserExtension
  #EasyContact.send :include, EasyredmineSipgateConnector::EasyContactExtension
end
#
# ApplicationController.send :include, EasyredmineSipgateHelper
# ApplicationController.send :helper, :easyredmine_sipgate