class AddMetainfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :profession, :string
    add_column :users, :title, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :was_in_boarding_school, :boolean, default: false
    add_column :users, :graduated, :boolean, default: false
    add_column :users, :nick_name, :string
    add_column :users, :school_year_begin, :date
    add_column :users, :school_year_end, :date
  end
end
