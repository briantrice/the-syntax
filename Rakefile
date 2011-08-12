task :default => :test

project = 'thesyntax'

filename_ext = 'ts'

task :parser do
  sh "kpeg -t lib/#{project}.kpeg"
  sh "kpeg -f -s lib/#{project}.kpeg"
end

task :formatter do
  sh "kpeg -f -s lib/formatter.kpeg"
end

task :clean do
  sh "find . -name '*.rbc' -delete; find . -name '*.#{filename_ext}c' -delete"
end

task :install do
  sh "rm *.gem; rbx -S gem uninstall #{project}; rbx -S gem build #{project}.gemspec; rbx -S gem install #{project}-*.gem --no-ri --no-rdoc"
end

task :reference do
  sh "./bin/#{project} -d docs/reference -s exit"
end

doctool = 'poesy'

#task :docs do
#  sh "./bin/#{project} ../#{doctool}/bin/#{doctool} docs/index.ddl -o _#{doctool}"
#end

#task :sync_docs do
#  sh "rsync -a -P -e \"ssh -p 7331\" _#{doctool}/ alex@atomy-lang.org:/srv/http/atomy-lang.org/site/docs/"
#end

task :spec => :parser do
  sh "rspec ./spec/parser_spec.rb"
end

task :test do
  sh "./bin/#{project} test/main.#{filename_ext}"
end
