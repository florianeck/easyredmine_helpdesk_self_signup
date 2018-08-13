class AddHelpdeskProjectSelfSignupEasyUserType < ActiveRecord::Migration
  
  def change
    add_column :easy_helpdesk_projects, :self_signup_easy_user_type_id, :integer
  end
  
end