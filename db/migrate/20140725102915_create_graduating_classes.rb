class CreateGraduatingClasses < ActiveRecord::Migration
  def change
    create_table :graduating_classes do |t|
      t.integer :users_count, default: 0, null: false
      t.date :year

      t.timestamps
    end
  end
end
