#Axons - model of the connections between nodes
class Axon
	def initialize( from, to )
		if(from.class == Node and to.class == Node)
			@from = from
			@to = to
		end
	end
	
	def traverse
		return to
	end
end