def pbcopy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
  puts " -> Copied to clipboard: #{str.to_s.truncate(10)} (#{str.size} chars)"
end

def json_pp(obj)
  puts JSON.pretty_generate(obj)
end
