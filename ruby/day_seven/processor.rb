require 'pry'
require '../../utils/colors'
file = File.open('input.txt')
input = file.read
test_file = File.open('test_input.txt')
test_input = test_file.read

class Directory
  attr_accessor :files, :directories, :parent, :name

  def initialize(parent, name)
    @name = name
    @parent = parent
    @directories = []
    @files = []
  end

  def size
    [directories.map(&:size).compact.sum, files.map(&:filesize).sum].compact.sum
  end

  def over_100000?
    size > 100_000
  end

  def less_than_step_two?
    size < 2143088
  end
end

class Fyle # File is already taken by ruby 😤
  attr_reader :filename, :filesize

  def initialize(filename, filesize)
    @filename = filename
    @filesize = filesize.to_i
  end
end

class Filesystem
  attr_accessor :root

  def initialize(root)
    @root = root
  end

  def fetch_directories(root)
    root.directories.map { |directory| [fetch_directories(directory), directory] }
  end

  def directories_until_100000
    fetch_directories(root).flatten.reject(&:over_100000?)
  end

  def directories_more_than_step_two
    fetch_directories(root).flatten.reject(&:less_than_step_two?)
  end

  def size
    root.size
  end

  def self.process_lines(lines)
    root = Directory.new(nil, lines.take(0))
    filesystem = new(root)
    working_directory = root

    lines.each_with_index do |line, index|
      next if index == 0 # Skip the first line cause we assigned this outside of the loop

      if line.include?('$')
        if line.include?('cd')
          dir_name = line.split(' cd ').last.strip
          if dir_name == '..'
            working_directory = working_directory.parent
          else
            working_directory = working_directory.directories.find { |dir| dir.name == dir_name }
          end
        end
      elsif line.include?('dir')
        working_directory.directories << Directory.new(working_directory, line.split(' ').last)
      elsif line =~ /\d+/
        filesize, filename = line.split(' ')
        working_directory.files << Fyle.new(filename, filesize)
      end
    end

    filesystem
  end
end

filesystem = Filesystem.process_lines(input.split(/\n/))
testfilesystem = Filesystem.process_lines(test_input.split(/\n/))


puts filesystem.directories_more_than_step_two.sort_by(&:size).first.size
