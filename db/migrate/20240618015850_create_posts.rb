class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :address
      t.integer :roommates_needed
      t.decimal :rent
      t.string :email

      t.timestamps
    end
  end
end
