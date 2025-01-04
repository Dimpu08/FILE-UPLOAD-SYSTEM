class CreateFileUploads < ActiveRecord::Migration[6.1]
  def change
    create_table :file_uploads do |t|
      t.string :title
      t.text :description
      t.string :file
      t.references :user, null: false, foreign_key: true
      t.string :shared_url

      t.timestamps
    end
    add_index :file_uploads, :shared_url
  end
end
