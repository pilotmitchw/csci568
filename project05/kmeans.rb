class DataObject
	attr_accessor :attributes
	def initialize(attributes)
		@attributes = attributes
	end
end

def read_file(file_name)
	data_objects = []
	file = File.new(file_name, "r")
	while(line = file.gets)
		split_line = line.split(',')
		data_objects << DataObject.new(split_line)
	end
	
	return data_objects
end

def print_all(data_objects)
	data_objects.foreach |i| do
		puts "Object: sepal le
	end
end


