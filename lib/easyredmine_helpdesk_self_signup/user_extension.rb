module EasyredmineHelpdeskSelfSignup::UserExtension
  
  extend ActiveSupport::Concern
  
  def assign_to_helpdesk_projects
    matcher = EasyredmineHelpdeskSelfSignup::MailDomainMatcher.new(self.email_address.address)
    
    matcher.project_matchings.each do |matching|
      member = Member.find_or_create_by(user_id: self.id, project_id: matching.easy_helpdesk_project.project_id)
      member.role_ids = ([matching.easy_helpdesk_project.self_signup_default_role])
      member.save
    end
  end
  
end