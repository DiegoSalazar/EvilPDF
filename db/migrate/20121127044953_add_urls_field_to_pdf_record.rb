class AddUrlsFieldToPdfRecord < ActiveRecord::Migration
  def change
    add_column :pdf_records, :urls, :text
  end
end
