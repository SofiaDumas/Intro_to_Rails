class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.integer :book_id
      t.string :title
      t.string :author
      t.string :isbn
      t.string :cover_image

      t.timestamps
    end
  end
end
