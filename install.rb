# Install hook code here
['/public/images/arrow_up.gif', '/public/images/arrow_down.gif'].each do |file|
  source = File.join(File.dirname(__FILE__), file)
  dest = RAILS_ROOT + file
  FileUtils.cp(source, dest)
end