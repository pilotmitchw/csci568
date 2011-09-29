class DataObject
	attr_accessor :attributes
	def initialize(attributes)
		@attributes = attributes
	end
end

class Centroid
	attr_accessor :location
	def initialize(location)
		@location = location
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
	data_objects.each do |i|
		puts "Object: sepal length = #{i.attributes[0]}, sepal width = #{i.attributes[1]}, petal length = #{i.attributes[2]}, petal width = #{i.attributes[3]}, class = #{i.attributes[4]}"
	end
end

data_objects = read_file("iris.csv")
print_all(data_objects);
