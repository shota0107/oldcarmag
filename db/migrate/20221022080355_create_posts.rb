class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :name,            null: false
      t.string :introduction
      t.string :profile_image_id
      t.timestamps
    end
  end
end
