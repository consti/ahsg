class AddGraduationClassToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :graduating_class, index: true
  end
end
