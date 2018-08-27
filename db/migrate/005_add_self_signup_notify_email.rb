class AddSelfSignupNotifyEmail < ActiveRecord::Migration
  
  def change
    add_column :easy_helpdesk_projects, :self_signup_notify_email, :string
  end
  
end