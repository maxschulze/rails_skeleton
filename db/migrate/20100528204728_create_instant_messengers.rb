class CreateInstantMessengers < ActiveRecord::Migration
  def self.up
    create_table :instant_messengers do |t|
      t.string :address
      t.string :protocol
      t.string :location
      t.integer :person_id

      t.timestamps
    end

    add_index :instant_messengers, :person_id
  end

  def self.down
    drop_table :instant_messengers
  end
end
