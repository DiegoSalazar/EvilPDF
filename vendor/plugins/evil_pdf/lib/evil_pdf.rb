class EvilPdf
  require 'open-uri'
  require 'pdfkit'
  
  def initialize(record, options = {})
    @record = record
    @options = options
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
  
  def get_file(url)
    @filename = url.split('/').last
    @html = open(url).read
  end
  
  def generate
    pdfkit = PDFKit.new @html, @options[:pdfkit] || {}
    @tmp_files << "#{Rails.root}/partial-#{@record.id}-#{Time.now.to_i}.pdf"
    pdfkit.to_file @tmp_files.last
  end
  
  # using ghostscript to combine multiple pdfs into 1
  def combine
    gs_opts = "-q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite"
    system "gs #{gs_opts} -sOutputFile=#{combined_name} #{@tmp_files.join(' ')}"
  end
  
  def combined_name
    @combined_name ||= "#{@options[:filename] || @record.name}-#{Time.now.to_i}.pdf"
  end
end
