class AddEasyContactIdToProjectMatchings < ActiveRecord::Migration
  
  def change
    add_column :easy_helpdesk_project_matchings, :easy_contact_id, :integer
  end
  
end