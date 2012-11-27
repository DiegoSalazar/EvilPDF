class EvilPdf < WickedPdf
  def self.generate(html, options = {})
    (@evil_pdf ||= new).generate html, options
  end
  
  def generate(s, options = {})
    t = Time.now.to_i
    root = "#{Rails.root}/tmp"
    Dir.mkdir root unless Dir.exists? root
    pdf_dir = "#{root}/pdf"
    Dir.mkdir pdf_dir unless Dir.exists? pdf_dir
    pdf_file = "#{pdf_dir}/#{options[:filename]}.pdf"
    
    pdf = EvilPdf.new.pdf_from_string s
    
    Rails.logger.info "---> PDF done in #{Time.now.to_i - t} secs"
    File.open(pdf_file, 'wb') { |f| f.puts pdf }
  end
end
