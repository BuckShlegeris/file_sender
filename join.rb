# ruby join.rb out.pdf 30

name = ARGV[0]
total = ARGV[1].to_i

File.open(name,'w') do |file|
  total.times do |counter|
    File.open("#{name}_part_#{counter+1}","r") do |infile|
      file.write(infile.read.chomp)
    end
    puts "#{counter+1}"
  end
