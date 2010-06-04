class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :title

      t.timestamps
    end
    
    create_table :groups_people, :id => false do |t|
      t.belongs_to :person
      t.belongs_to :group
    end
    
    add_index :groups_people, :person_id
    add_index :groups_people, :group_id
    
    create_table :companies_groups, :id => false do |t|
      t.belongs_to :company
      t.belongs_to :group
    end
    
    add_index :companies_groups, :company_id
    add_index :companies_groups, :group_id
  end

  def self.down
    remove_index :groups_people, :group_id
    remove_index :groups_people, :person_id
    
    drop_table :groups
    drop_table :groups_people
  end
end