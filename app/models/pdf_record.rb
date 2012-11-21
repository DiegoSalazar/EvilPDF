class PdfRecord < ActiveRecord::Base
  attr_accessible :content, :name, :pdf
  
  has_attached_file :pdf, { 
    :storage => :s3, 
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :bucket => 'pdf_record_test',
    :path => "/:class/:id/:filename"
  }
  
  before_save :generate_pdf
  
  def generate_pdf
    pdf = EvilPdf.generate content, :filename => name if new_record? || content_changed?
  end
end
