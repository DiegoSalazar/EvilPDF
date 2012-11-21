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
    root = "#{Rails.root}/tmp/pdf/"
    Dir.mkdir root unless Dir.exists? root
    pdf_file = "#{root}#{options[:filename]}.pdf"
    pdf = WickedPdf.new.pdf_from_string s
    Rails.logger.debug "---> PDF done in #{Time.now.to_i - t} secs"
    File.open(pdf_file, 'wb') { |f| f.puts pdf }
    File.open(pdf_file, 'r')
  end
end
