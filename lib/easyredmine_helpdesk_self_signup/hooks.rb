module EasyredmineHelpdeskSelfSignup
  class Hooks < Redmine::Hook::ViewListener
    
    render_on :view_easy_helpdesk_project_settings_bottom, :partial => 'projects/settings/easy_helpdesk_self_signup_settings'
    
    #render_on :view_users_easy_profile_bottom, :partial => 'users/easy_contacts_list'
    
    
  end
end