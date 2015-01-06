desc 'Test zone files'
task :test do
  Dir.chdir('zones') do
    Dir.glob('*.zone').each do |zonefile|
      zone = zonefile.sub(/\.zone$/, '')
      check = system("named-checkzone #{zone} #{zonefile}")
      fail("Broken zone: #{zone}") unless check
    end
  end
end

task default: [:test]
