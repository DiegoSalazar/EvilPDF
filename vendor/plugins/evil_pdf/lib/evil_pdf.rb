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
    tmp_file = "#{Rails.root}/tmp/pdf-#{t}.html"
    File.open(tmp_file, 'w') { |f| f.puts s }
    pdf = `wkhtmltopdf #{tmp_file} #{options[:filename]}`
    Rails.logger.debug "---> PDF done in #{Time.now.to_i - t} secs"
    `rm #{tmp_file}`
    pdf
  end
end
