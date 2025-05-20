begin
  require 'awesome_print'
rescue LoadError
  # sometimes awesome_print isn't available,
  # like when installing a new version or ruby and running "bundle install awesome_print"
  if $VERBOSE || $DEBUG
    puts "awesome_print not available"
  end
end

if $VERBOSE || $DEBUG
  puts "#{__FILE__} loaded"
  puts "RUBYOPT: #{ENV['RUBYOPT']}"
  puts "---"
end
