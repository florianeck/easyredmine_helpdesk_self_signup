class AddUserEasyContactId < ActiveRecord::Migration
  
  def change
    add_column :users, :easy_contact_id, :integer
  end
  
end