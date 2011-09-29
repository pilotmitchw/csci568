class DataObject
	attr_accessor :attributes
	def initialize(attributes)
		@attributes = attributes
	end
end

class EuclideanDistance
	def distance(x, y)
		#Dimensionality
		xDimensions = x.attributes.length
		yDimensions = y.attributes.length
		
		#No point in comparing objects with different dimensionalities
		if xDimensions != yDimensions 
			return nil
		end
		
		total = 0
		
		xDimensions.times do |i|
			total += (x.attributes[i] - y.attributes[i])**2
		end
		
		return Math.sqrt(total)
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

def k_means_clustering (k, data_objects)
	
end

data_objects = read_file("iris.csv")
print_all(data_objects);
