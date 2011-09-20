class DataObject
	attr_accessor :attributes
	def initialize (attributes)
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

class SimpleMatchingCoefficient
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
			if x.attributes[i] == y.attributes[i]
				total += 1
			end
		end
		
		return total.to_f / xDimensions
	end
end

class JaccardSimilarity
	def distance(x,y)
		#Dimensionality
		xDimensions = x.attributes.length
		yDimensions = y.attributes.length
		
		#No point in comparing objects with different dimensionalities
		if xDimensions != yDimensions 
			return nil
		end
		
		total = 0
		
		xDimensions.times do |i|
			if x.attributes[i] == 1 and y.attributes[i] == 1
				total += 1
			end
		end
		
		return total.to_f / xDimensions
	end
end

class PearsonCorrelationCoefficient
	def distance(x,y)
		#Dimensionality
		xDimensions = x.attributes.length
		yDimensions = y.attributes.length
		
		#No point in comparing objects with different dimensionalities
		if xDimensions != yDimensions 
			return nil
		end
		
		total = 0
		
		x_mean = 0
		y_mean = 0
		
		xDimensions.times do |i|
			x_mean += x.attributes[i]
			y_mean += y.attributes[i]
		end
		
		x_mean = x_mean / xDimensions
		y_mean = y_mean / yDimensions
		
		stdev_x = 0
		stdev_y = 0
		
		xDimensions.times do |i|
			stdev_x += (x.attributes[i] - x_mean)**2
			stdev_y += (y.attributes[i] - y_mean)**2
		end
		
		stdev_x = Math.sqrt(stdev_x/(xDimensions - 1))
		stdev_y = Math.sqrt(stdev_y/(yDimensions - 1))
		
		
	end
end

class CosineSimilarity
	def distance(x,y)
		#Dimensionality
		xDimensions = x.attributes.length
		yDimensions = y.attributes.length
		
		#No point in comparing objects with different dimensionalities
		if xDimensions != yDimensions 
			return nil
		end
		
		total = 0
		x_dot_y = 0
		x_dot_x = 0
		y_dot_y = 0
		
		xDimensions.times do |i|
			x_dot_y += x.attributes[i] * y.attributes[i]
			x_dot_x += x.attributes[i] * x.attributes[i]
			y_dot_y += y.attributes[i] * y.attributes[i]
		end
		
		x_dot_x = Math.sqrt(x_dot_x)
		y_dot_y = Math.sqrt(y_dot_y)
		
		return x_dot_y.to_f / (x_dot_x * y_dot_y)
	end
end



one = DataObject.new([10, 15])
two = DataObject.new([80, -12])

same_one = DataObject.new([1, 0])
same_two = DataObject.new([1, 0])


e = EuclideanDistance.new
smc = SimpleMatchingCoefficient.new
jaccard = JaccardSimilarity.new
cosine = CosineSimilarity.new

puts "Euclidian: #{e.distance(one, two)}"
puts "SMC: #{smc.distance(same_one, same_two)}"
puts "Jaccard: #{jaccard.distance(same_one, same_two)}"
puts "Cosine similarity: #{cosine.distance(one, two)}"
