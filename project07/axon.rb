#Axons - model of the connections between nodes
class Axon
	def initialize( from, to, weight=1.0 )
		if(from.class == Node and to.class == Node)
			@from = from
			@to = to
			@weight = weight
		end
	end
	
	def set_weight( weight )
		@weight = weight.to_f
	end
	
	def get_weight
		return @weight
	end
	
	#Traversing an axon means that we go along the connection,
	#applying the weight and supplying the signal from the
	#'from' neuron to the 'to' neuron.
	def traverse
		
	end
	
end