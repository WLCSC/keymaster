class CreateKeyrings < ActiveRecord::Migration
  def change
    create_table :keyrings do |t|
      t.integer :person_id
      t.integer :key_id

      t.timestamps
    end
  end
end
