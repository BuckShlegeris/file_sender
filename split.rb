# ruby split.rb blah 1000 means split blah into files of size 1kB

size = ARGV[1].to_i
name = ARGV[0]

counter = 1


File.open(name,'rb') do |file|
  until file.eof?
    buffer = file.read(size)
   # puts "#{buffer}, #{counter}"
    File.open("#{name}_part_#{counter}","w") do |outfile|
      outfile.write(buffer)
    end

    counter += 1
  end
end
