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
	
	end
end

class CosineSimilarity
	def distance(x,y)
	
	end
end



one = DataObject.new([10, 15])
two = DataObject.new([80, -12])

same_one = DataObject.new([1, 0])
same_two = DataObject.new([1, 0])


e = EuclideanDistance.new
smc = SimpleMatchingCoefficient.new
jaccard = JaccardSimilarity.new

puts "Euclidian: #{e.distance(one, two)}"
puts "SMC: #{smc.distance(same_one, same_two)}"
puts "Jaccard: #{jaccard.distance(same_one, same_two)}"
