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

def pps(*args)
  ap "----- #{ap caller.first}"
  args.each do |arg|
    ap arg, {sort_vars: false, sort_keys: false, indent: -2}
  end
  ap "--------------------------------------------------"
end
