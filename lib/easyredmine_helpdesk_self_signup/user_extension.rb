module EasyredmineHelpdeskSelfSignup::UserExtension
  
  extend ActiveSupport::Concern
  
  included do
    after_create :setup_easy_contact, :assign_to_helpdesk_projects, :assign_contact_to_projects
  end
  
  def easy_contacts_by_user_email
    matching_email = CustomValue.where(custom_field_id: EasyredmineHelpdeskSelfSignup.cf_mail_id, value: self.email_address.address)
    matching_email.map(&:customized)
  end
  
  def easy_contacts_by_user_id
    matching_email = CustomValue.where(custom_field_id: EasyredmineHelpdeskSelfSignup.cf_user_id, value: self.id)
    matching_email.map(&:customized)
  end
  
  private
  
  def setup_easy_contact
    return if self.email_address.nil? || 
    
    if self.easy_contacts_by_user_email.any?
      easy_contacts.each {|c| c.update_attributes(custom_field_values: { EasyredmineHelpdeskSelfSignup.cf_user_id => self.id } )}
    else
      ec = EasyContact.new(
        firstname: firstname, lastname: lastname,
        custom_field_values: {
          EasyredmineHelpdeskSelfSignup.cf_mail_id => self.email_address.address,
          EasyredmineHelpdeskSelfSignup.cf_user_id => self.id
        },
        type_id: 1, is_global: false
      )
    
      ec.save
    end
  end
  
  def assign_to_helpdesk_projects
    matcher = EasyredmineHelpdeskSelfSignup::MailDomainMatcher.new(self.email_address.address)
    
    matcher.project_matchings.each do |matching|
      member = Member.find_or_create_by(user_id: self.id, project_id: matching.easy_helpdesk_project.project_id)
      member.role_ids = ([matching.easy_helpdesk_project.self_signup_default_role])
      member.save
      self.easy_user_type_id = matching.easy_helpdesk_project.self_signup_easy_user_type_id
    end
    
    self.save
  end
  
  def assign_contact_to_projects  
    projects.each do |project|
      easy_contacts_by_user_id.each do |contact|
        EasyContactEntityAssignment.create(easy_contact_id: contact.id, entity: project)
      end  
    end
  end
  
end