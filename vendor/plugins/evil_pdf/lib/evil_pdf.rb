class EvilPdf
  require 'open-uri'
  require 'pdfkit'
  
  def initialize(record, options = {})
    @record = record
    @options = options
    Dir.mkdir './tmp' unless Dir.exists? './tmp'
  end
  
  def from_urls(urls)
    @tmp_files = []
    urls.each_with_index do |url, i|
      get_file url
      generate
    end
    combine
    File.open combined_name, 'r'
  end
  
  def to_file(name)
    PDFKit.new(@html, @options).to_file name
  end
  
  private
  
  def get_file(url)
    @filename = url.split('/').last
    @html = open(url).read
  end
  
  def generate
    tmp_file = "./tmp/partial-#{@record.id}-#{SecureRandom.hex(16)}.pdf"
    to_file tmp_file
    @tmp_files << tmp_file
  end
  
  # using ghostscript to combine multiple pdfs into 1
  def combine
    gs_opts = "-q -dNOPAUSE -sDEVICE=pdfwrite"
    gs_cmd = "gs #{gs_opts} -sOutputFile=#{combined_name} -dBATCH #{@tmp_files.join(' ')}"
    Rails.logger.fatal "Combining PDFs: #{gs_cmd}"
    system gs_cmd
  end
  
  def combined_name
    @combined_name ||= "./tmp/#{(@options[:filename] || @record.name).parameterize}-#{Time.now.to_i}.pdf"
  end
end
