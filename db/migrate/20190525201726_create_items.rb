class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.integer :amount
      t.boolean :completed

      t.timestamps
    end
  end
end
