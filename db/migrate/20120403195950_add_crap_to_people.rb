class AddCrapToPeople < ActiveRecord::Migration
  def change
    add_column :people, :tornado, :text

    add_column :people, :fire, :text

    add_column :people, :rooms, :string

    add_column :people, :teaching_areas, :string

  end
end
