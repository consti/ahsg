class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
      t.integer :author_id
      t.text :text

      t.timestamps
    end
  end
end
