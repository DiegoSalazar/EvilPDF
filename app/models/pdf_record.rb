class PdfRecord < ActiveRecord::Base
  attr_accessible :content, :name
  
  if Rails.env.production?
    has_attached_file :pdf, { 
      :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :path => "/:class/:id/:filename"
    }
  else
    has_attached_file :pdf
  end
  
  before_save :generate_pdf
  
  def generate_pdf
    pdf = EvilPdf.generate content, :filename => name
  end
end
