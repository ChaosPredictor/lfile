source 'https://rubygems.org'

gemfiles = [ 'Gemfile_base', 'Gemfile_development' ]
#gemfiles = [ 'Gemfile_base', 'Gemfile_production' ]
gemfiles.each do |gemfile|
  instance_eval File.read(gemfile)
end
