#Axons - model of the connections between Neurons
class Axon
	def initialize( from, to, weight=1.0 )
		if(from.class == Neuron and to.class == Neuron)
			@from = from
			@to = to
			@weight = weight
			
			@from.connect_output( self )
			@to.connect_input( self )
		end
	end
	
	def set_weight( weight )
		@weight = weight.to_f
	end
	
	def get_weight
		return @weight
	end
	
	def get_value
	
		value = @from.get_value.to_f*@weight		
		#puts "Axon value was: #{value}"
		return value
	end
	
end