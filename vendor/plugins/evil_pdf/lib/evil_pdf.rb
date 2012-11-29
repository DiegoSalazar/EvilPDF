class EvilPdf
  require 'open-uri'
  require 'pdfkit'
  attr_reader :file_handle
  
  def initialize(record, options = {})
    @record = record
    @options = options
    Dir.mkdir './tmp' unless Dir.exists? './tmp'
    self.class.handle_asynchronously :from_urls if options[:async]
  end
  
  def from_urls(urls)
    @tmp_files = []
    urls.each_with_index do |url, i|
      get_file(url) and generate(i)
    end
    combine
    File.open file_name, 'r'
  end
  
  def from_urls!(urls)
    @file_handle = from_urls urls
    self
  end
  
  def to_file(name)
    PDFKit.new(@html, @options).to_file name
  end
  
  def file_name
    @file_name ||= "./tmp/#{@record.name.parameterize}-#{Time.now.to_i}.pdf"
  end
  
  private
  
  def get_file(url)
    @filename = url.split('/').last
    @html = open(url).read
  rescue OpenURI::HTTPError => e
    @record.errors.add :pdf, "HTTPError #{e.message}: #{url}"
    false
  end
  
  def generate(i)
    tmp = "./tmp/partial-#{Time.now.to_i}-#{i}.pdf"
    to_file tmp
    @tmp_files << tmp
  end
  
  # using ghostscript to combine multiple pdfs into 1
  def combine
    gs_opts = "-q -dNOPAUSE -sDEVICE=pdfwrite"
    gs_cmd = "gs #{gs_opts} -sOutputFile=#{file_name} -dBATCH #{@tmp_files.join(' ')}"
    Rails.logger.debug "Combining PDFs: #{gs_cmd}"
    system gs_cmd
  end
end
