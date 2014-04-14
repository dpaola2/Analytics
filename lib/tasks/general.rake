
task :reextract_standard_events => :environment do
  StandardEvent.all.each do |se|
    puts "Extracting #{se.id}"
    se.reextract!
  end
end
