class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :commentbody
      t.integer :user_id
      t.integer :image_id

      t.timestamps
    end
  end
end
