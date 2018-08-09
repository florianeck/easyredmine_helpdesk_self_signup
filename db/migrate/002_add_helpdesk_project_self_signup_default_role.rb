class AddHelpdeskProjectSelfSignupDefaultRole < ActiveRecord::Migration
  
  def change
    add_column :easy_helpdesk_projects, :self_signup_default_role, :integer
  end
  
end