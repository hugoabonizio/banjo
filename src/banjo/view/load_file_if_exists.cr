file_name = ARGV[0]
if File.exists? file_name
  print file_name
else
  print "/dev/null"
end