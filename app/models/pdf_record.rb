class PdfRecord < ActiveRecord::Base
  attr_accessible :content, :name, :pdf, :urls, :async
  attr_accessor :async
  
  has_attached_file :pdf, { 
    :storage => :s3, 
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :bucket => 'pdf_record_test',
    :path => "/:class/:id/:filename"
  }
  validates_attachment_content_type :pdf, :content_type => ['application/pdf', 'application/x-pdf']
  validates_presence_of :name
  
  def pdf_from_urls(async = false)
    self.pdf = EvilPdf.new(self, :async => async == '1').from_urls urls.lines
    save unless async == '1'
  end
end
