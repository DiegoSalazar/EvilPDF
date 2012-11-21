class EvilPdf < WickedPdf
  def self.generate(html, options = {})
    (@evil_pdf ||= new).string_to_pdf html, options
  end
  
  def initialize
    super
    @exe_path = '/usr/local/Cellar/wkhtmltopdf/0.11.0_rc1/bin/wkhtmltopdf'
  end
  
  def string_to_pdf(s, options = {})
    t = Time.now.to_i
    root = "#{Rails.root}/tmp"
    Dir.mkdir root unless Dir.exists? root
    pdf_dir = "#{root}/pdf"
    Dir.mkdir pdf_dir unless Dir.exists? pdf_dir
    pdf_file = "#{pdf_dir}/#{options[:filename]}.pdf"
    
    pdf = WickedPdf.new.pdf_from_string s
    
    Rails.logger.fatal "---> PDF done in #{Time.now.to_i - t} secs"
    File.open(pdf_file, 'wb') { |f| f.puts pdf }
    File.open(pdf_file, 'r')
  end
end
