# 2019-02-09 (cc) <paul4hough@gmail.com>
#

$runstart = Time.now

at_exit {
  runtime = Time.at(Time.now - $runstart).utc.strftime("%H:%M:%S.%3N")
  puts "run time: #{runtime}"
}

desc 'validate yml files'
task :yamllint do
  sh "yamllint -f parsable" + \
     " puppet/modules/maul_testbed_role" + \
     " puppet/modules/maul"
end

desc 'vagrant provision'
task :provision => [:yamllint] do
  sh "vagrant provision"
end
desc 'vagrant up'
task :up => [:yamllint] do
  sh "vagrant up"
end
