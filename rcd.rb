# rcd.rb (remove consecutive delimiters)
# This script takes a text file and a delimiter and
# replaces any instances of consecutive delimiters with a single delimiter

require 'optparse'

class DelimiterRemover

  def initialize
    @options = {}
    @parser = OptionParser.new do |opts|
      opts.banner = "Usage: rcd.rb [OPTIONS] -f FILE -d DELIMITER"

      # verbosity
      @options[:verbose] = false 
      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        @options[:verbose] = true
      end

      # input
      @options[:input] = $stdin
      opts.on("-f", "--file FILE", "Target input file") do |file|
        @options[:input] = File.open(file, 'r')
      end

      # delimiter
      @options[:del] = ' '
      opts.on("-d", "--del DEL", "Require delimiter.") do |del|
        @options[:del] = del.strip
      end

      # output
      @options[:output] = $stdout
      opts.on("-t", "--target FILE", "Target save file.") do |file|
        @options[:output] = File.open(file, 'w')
      end
    end
    self
  end

  def parse!
    @parser.parse!
    self
  end

  def run
    puts "Current options are #{@options}." if @options[:verbose]
    @options[:input].readlines.each do |line|
      @options[:output].puts line.gsub(/#{@options[:del]}+/, @options[:del])
    end
    self
  end
end

if __FILE__ == $0
  DelimiterRemover.new.parse!.run
end
