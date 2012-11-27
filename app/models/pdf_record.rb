class PdfRecord < ActiveRecord::Base
  attr_accessible :content, :name, :pdf, :urls
  
  has_attached_file :pdf, { 
    :storage => :s3, 
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :bucket => 'pdf_record_test',
    :path => "/:class/:id/:filename"
  }
  validates_attachment_content_type :pdf, :content_type => ['application/pdf', 'application/x-pdf']
  
  def pdf_from_urls
    pdf = EvilPdf.new(self).from_urls urls.split("\n").map(&:strip)
    save
  end
end
