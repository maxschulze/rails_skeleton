class CreateWebPresences < ActiveRecord::Migration
  def self.up
    create_table :web_presences do |t|
      t.string :network
      t.string :url
      t.string :location
      t.integer :person_id

      t.timestamps
    end

    add_index :web_presences, :person_id
  end

  def self.down
    drop_table :web_presences
  end
end
