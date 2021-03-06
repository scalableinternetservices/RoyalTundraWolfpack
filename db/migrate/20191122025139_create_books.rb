class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :upvotes

      t.timestamps
    end
    add_index :books, :title, unique: true
  end
end
