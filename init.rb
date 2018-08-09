Redmine::Plugin.register :easyredmine_helpdesk_self_signup do
  name 'EasyRedmine SelfSignup'
  author 'Florian Eck for akquinet'
  description 'Assign self-signup customers to helpdesk projects'
  version '1.0'
end

require "easyredmine_helpdesk_self_signup"
