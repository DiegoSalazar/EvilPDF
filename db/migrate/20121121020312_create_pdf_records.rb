class CreatePdfRecords < ActiveRecord::Migration
  def change
    create_table :pdf_records do |t|
      t.string :name
      t.text :content
      t.string :pdf_file_name
      t.integer :pdf_file_size
      t.string :pdf_content_type

      t.timestamps
    end
  end
end
