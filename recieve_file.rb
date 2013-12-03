require 'socket'

$hostname = '10.0.1.154' #'199.241.200.213'
$port = 8081

begin
  $socket = TCPSocket.open($hostname, $port)
rescue Errno::ECONNREFUSED => error
  retry
end

puts "socket opened"

def recieve_file(directory_name)
  filename = $socket.gets.chomp

  if filename == "done"
    return true
  end

  if File.exists?("#{directory_name}/#{filename}")
    $socket.puts "No thanks, I've already got that one"
    return
  end

  $socket.puts "Oooh, please send that!"

  puts "filename is '#{filename}'"

  filesize = $socket.gets.chomp.to_i

  File.open("#{directory_name}/#{filename}", "wb") do |file|
    (filesize).times do
      data = $socket.gets
      file.write(data)
    end
  end

  return false
end

def recieve_files
  directory_name = $socket.gets.chomp
  Dir.mkdir(directory_name) unless Dir.exists?(directory_name)

  until recieve_file(directory_name)
  end
end

recieve_files