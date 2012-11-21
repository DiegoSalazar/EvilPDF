class PdfRecord < ActiveRecord::Base
  attr_accessible :content, :name
  has_attached_file :pdf
  
  def before_save
    pdf = EvilPdf.string_to_pdf content, :filename => name
  end
end
