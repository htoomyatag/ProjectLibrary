class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.boolean :is_private, default: false
      t.boolean :is_owner, default: true
      t.integer :user_id

      t.timestamps
    end
  end
end
