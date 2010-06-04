class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string    :first_name
      t.string    :last_name
      t.string    :title, :salutation
      t.string    :gender, :default => 'male'
      t.integer   :company_id
      t.integer   :visible_to, :default => 1
      t.boolean   :important, :default => false
      t.string    :state, :default => 'active'
      t.date      :birthdate
      t.string    :relationship_status
      t.text      :notes
      t.datetime  :deleted_at
      
      t.timestamps
    end
    
    add_index :people, :company_id
    add_index :people, :important
    add_index :people, :state
    add_index :people, :visible_to
    add_index :people, :gender
  end

  def self.down
    remove_index :people, :gender
    remove_index :people, :visible_to
    remove_index :people, :state
    remove_index :people, :important
    remove_index :people, :company_id
    
    drop_table :people
  end
end