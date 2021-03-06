module EasyredmineHelpdeskSelfSignup
  class Hooks < Redmine::Hook::ViewListener
    
    render_on :view_easy_helpdesk_project_settings_bottom, :partial => 'projects/settings/easy_helpdesk_self_signup_settings'
    render_on :view_settings_notifications_bottom, :partial => 'projects/settings/self_signup_default_notify_mail'
    
  end
end