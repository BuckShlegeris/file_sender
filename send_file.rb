$server = TCPServer.open(8081)
$socket = $server.accept

STDOUT.puts "socket opened, #{ARGV[0]}"

def send_file(directory, filename)
  $socket.puts filename

  response = $socket.gets.chomp

  if response == "No thanks, I've already got that one"
    return
  end

  result = `wc -l #{directory}/#{filename}`

  $socket.puts result

  data = File.open("#{directory}/#{filename}", 'rb').read

  $socket.write(data)
end

def send_all_files(directory)
  $socket.puts directory

  Dir.entries(directory).each do |filename|
    next unless filename =~ /^[^\s]*\.hs$/
    send_file(directory,filename)
  end

  $socket.puts "done"
end

