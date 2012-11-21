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
    tmp_file = "#{root}#{t}.html"
    pdf_file = "#{root}#{options[:filename]}.pdf"
    #File.open(tmp_file, 'w') { |f| f.puts s }
    pdf = WickedPdf.new.pdf_from_string s, :pdf => pdf_file #`wkhtmltopdf #{tmp_file} #{pdf_file}`
    Rails.logger.debug "---> PDF done in #{Time.now.to_i - t} secs"
    pdf = File.open(pdf_file, 'r').dup
    `rm #{tmp_file} #{pdf_file}`
    pdf
  end
end
