module EasyredmineHelpdeskSelfSignup::EasyContactExtension
  
  extend ActiveSupport::Concern
  
  included do
    after_save :create_easy_helpdesk_project_matchings
  end
  
  def helpdesk_projects
    EasyHelpdeskProject.where(project_id: projects.pluck(:id))
  end
  
  def create_easy_helpdesk_project_matchings
    helpdesk_projects.pluck(:id).each do |hid|
      matching = EasyHelpdeskProjectMatching.find_or_initialize_by(easy_contact_id: self.id, easy_helpdesk_project_id: hid, email_field: 'from')
      matching.domain_name = self.email
      matching.save
    end
  end
  
  def email
    custom_field_value(EasyContacts::CustomFields.email_id)
  end
end