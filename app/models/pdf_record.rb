class PdfRecord < ActiveRecord::Base
  attr_accessible :content, :name
  has_attached_file :pdf
  
  before_save :generate_pdf
  
  def generate_pdf
    pdf = EvilPdf.generate content, :filename => name
  end
end
