class DataObject
	attr_accessor :attributes, :class_name
	def initialize(attributes, class_name)
		@attributes = attributes
		@class_name = class_name
	end
	
	def print
		puts "Object: sepal length = #{@attributes[0]}, sepal width = #{@attributes[1]}, petal length = #{@attributes[2]}, petal width = #{@attributes[3]}, class = #{@class_name}"
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
	attr_accessor :attributes, :data_objects
	def initialize(location)
		@attributes = location
		@data_objects = []
	end
	
	def add (data_object)
		@data_objects << data_object
	end
	
	def clear_objects
		@data_objects.clear
	end
	
	def print
		puts "Centroid location: #{@attributes[0]}, #{@attributes[1]},#{@attributes[2]},#{@attributes[3]}"
		puts "Centroid data points:"
		data_objects.each do |i|
			i.print
		end
			
	end
end

def read_file(file_name)
	data_objects = []
	file = File.new(file_name, "r")
	while(line = file.gets)
		split_line = line.split(',')
		
		formatted_split_line = []
		class_name = ""
		
		split_line.each do |part|
			if(part.to_f != 0.0) #to_f returns 0.0 if not a valid number
				formatted_split_line << part.to_f
			else
				class_name = part
			end
		end
		data_objects << DataObject.new(formatted_split_line, class_name)
	end
	
	return data_objects
end

def print_all(data_objects)
	data_objects.each do |i|
		puts "Object: sepal length = #{i.attributes[0]}, sepal width = #{i.attributes[1]}, petal length = #{i.attributes[2]}, petal width = #{i.attributes[3]}, class = #{i.class_name}"
	end
end

class KMeans

	def initialize()
		@distance_metric = EuclideanDistance.new
	end
	
	def cluster (k, data_objects)
		
		centroids = []
		@dimensionality = data_objects[0].attributes.length
		k.times do |i| 
			location = []
			
			@dimensionality.times do |j|
				location << rand(10).to_f
			end
			
			centroids << Centroid.new(location)
		end
		
		centroids.each { |i| i.print }
		centroids_moved = true
		
		while centroids_moved 
			centroids_moved = false
			
			good_centroids = false
			
			while not good_centroids
				good_centroids = true
				#Calculate proximity for each point to each centroid and assign each point to its closest centroid.
				data_objects.each do |data_object|
					#puts "Processing data object"
					#data_object.print
					closest = nil
					distance_buffer = 10000; #Initialize to something better.
					centroids.each do |centroid|
						distance = @distance_metric.distance(data_object, centroid)
						#puts "Distance: #{distance}"
						#puts "Distance buffer: #{distance_buffer}"
						if(not distance.nil? and distance < distance_buffer)
							closest = centroid
							distance_buffer = distance
						end
					end
				
					closest.add(data_object)
				end
			
				#look for centroids with no objects
				centroids.each do |centroid|
					if (centroid.data_objects.nil? or centroid.data_objects.length == 0)
						puts "Empty centroid after intitial allocation!"
						good_centroids = false
						
						location = []
			
						@dimensionality.times do |j|
						location << rand(10).to_f
						
						centroid.attributes = location
			end
					end
				end
			end
			
			
			
			#Calculate the average of all of each centroid's data objects, then move the centroid to that location
			centroids.each do |centroid|
				average_attributes = []
				
				#Dimensionality is equal to number of values in centroid's attribute field
				centroid.attributes.each_with_index do |centroid_attribute, index|
					total_for_attribute = 0.0
				
					centroid.data_objects.each do |data_object|
						total_for_attribute += data_object.attributes[index]
					end
					
					#puts centroid.data_objects.length
					if(centroid.data_objects.length != 0)
						average_attributes << total_for_attribute / centroid.data_objects.length
					else
			
					end
				end
				
				average_attributes.each_with_index do |avg, index|
					if(centroid.attributes[index] != avg)
						#puts "Centroid was at #{centroid.attributes[index]}, will be at #{avg}"
						centroids_moved = true
					end
				end
				
				puts "Setting centroid to location: #{average_attributes[0]}, #{average_attributes[1]}, #{average_attributes[2]}, #{average_attributes[3]}"
				centroid.attributes = average_attributes
				if(centroids_moved)
					centroid.clear_objects
				end
				
			end

		end
		
		puts "Done with K-means algorithm."
		puts "----------------------------"
		centroids.each_with_index do |centroid, index|
			puts "Centroid #{index+1}" 
			centroid.print
		end
		
		
	end
end

data_objects = read_file("iris.csv")
k_means = KMeans.new

k_means.cluster(3, data_objects)


