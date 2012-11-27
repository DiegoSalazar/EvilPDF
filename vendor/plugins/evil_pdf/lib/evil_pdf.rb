class EvilPdf < WickedPdf
  def self.generate(html, options = {})
    (@evil_pdf ||= new).generate html, options
  end
  
  def generate(s, options = {})
    Rails.logger.debug "Started PDF gen"
    t = Time.now.to_i
    root = "#{Rails.root}/tmp"
    Dir.mkdir root unless Dir.exists? root
    pdf_dir = "#{root}/pdf"
    Dir.mkdir pdf_dir unless Dir.exists? pdf_dir
    pdf_file = "#{pdf_dir}/#{options[:filename]}.pdf"
    
    pdf = EvilPdf.new.pdf_from_string s
    
    Rails.logger.debug "---> PDF done in #{Time.now.to_i - t} secs"
    f = File.open(pdf_file, 'wb') { |f| f.puts pdf }
    Rails.logger.debug "Generated PDF! #{f.size}"
    f
  end
end
