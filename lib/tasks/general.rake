
task :reextract_standard_events => :environment do
  StandardEvent.all.each do |se|
    puts "Extracting #{se.id}"
    se.reextract!
  end
end

task :compute_segments => :environment do
  segments = SegmentDefinition.all
  segments.each do |seg|
    seg.delay.recompute!
  end
end

task :parse_events => :environment do
  events = Event.where("properties is NULL")
  events.find_in_batches(batch_size: 100) do |event_batch|
    event_batch.each do |event|
      event.delay.parse
    end
  end
end
