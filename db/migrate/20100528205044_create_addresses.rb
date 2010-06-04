class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer :zip
      t.string :city
      t.string :street
      t.string :country
      t.integer :person_id
      t.string :location
      t.float :lng
      t.float :lat

      t.timestamps
    end

    add_index :addresses, :person_id
  end

  def self.down
    drop_table :addresses
  end
end
