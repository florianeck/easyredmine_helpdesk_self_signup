class RecreateUsersEasyContacts < ActiveRecord::Migration
  
  def change
    remove_column :users, :easy_contact_id, :integer
    
    cf = EasyContactCustomField.new({
      name: 'User',
      internal_name: 'easy_contacts_user',
      field_format: 'easy_lookup',
      is_filter: true, searchable: true, visible: true, editable: true
      
    })
    
    cf.settings = {"entity_type":"User","entity_attribute":"username"}
    cf.contact_type_ids = EasyContactType.all.map(&:id)
    cf.save
  end
  
end