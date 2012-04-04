class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :code

      t.timestamps
    end
  end
end
