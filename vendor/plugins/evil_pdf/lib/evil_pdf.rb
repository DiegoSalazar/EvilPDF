class EvilPdf < WickedPdf
  def initialize
    super
    @exe_path = '/usr/local/Cellar/wkhtmltopdf/0.11.0_rc1/bin/wkhtmltopdf'
  end
  
  def string_to_pdf(s, options = {})
    tmp_file = "#{Rails.root}/tmp/pdf-#{Time.now.to_i}.html"
    File.open(tmp_file, 'w') { |f| f.puts s }
    `wkhtmltopdf #{tmp_file} #{options[:filename]} && rm #{tmp_file}`
  end
end

@r = EvilPdf.new