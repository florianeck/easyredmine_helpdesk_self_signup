module EasyredmineHelpdeskSelfSignup::UserExtension
  
  extend ActiveSupport::Concern
  
  included do
    belongs_to :easy_contact
    after_create :setup_easy_contact, :assign_to_helpdesk_projects, :assign_contact_to_projects
  end
  
  def easy_contact_by_users_email
    cf_id = EasyContactCustomField.find_by_internal_name("easy_contacts_email").id
    matching_email = CustomValue.find_by(custom_field_id: cf_id, value: self.email_address.address)
    matching_email.try(:customized)
  end
  
  private
  
  def setup_easy_contact
    return if self.email_address.nil?
    
    ec = easy_contact || easy_contact_by_users_email
    if ec.present? && easy_contact.nil?
      self.update_column(:easy_contact_id, ec.id)
    elsif ec.nil?
      cf_id = EasyContactCustomField.find_by_internal_name("easy_contacts_email").id
      
      ec = EasyContact.new(
        firstname: firstname, lastname: lastname,
        custom_field_values: {cf_id => self.email_address.address},
        type_id: 1, is_global: false
      )
      
      ec.save
      self.update_column(:easy_contact_id, ec.id)
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
      EasyContactEntityAssignment.create(easy_contact_id: self.easy_contact.id, entity: project)
    end
    
  end
  
end