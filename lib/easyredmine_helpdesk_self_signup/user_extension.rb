module EasyredmineHelpdeskSelfSignup::UserExtension
  
  extend ActiveSupport::Concern
  
  def assign_to_helpdesk_projects
    matcher = EasyredmineHelpdeskSelfSignup::MailDomainMatcher.new(self.email_address.address)
    
    matcher.project_matchings.each do |matching|
      Member.find_or_create_by(user_id: self.id, project_id: matching.helpdesk_project.project_id)
    end
  end
  
end