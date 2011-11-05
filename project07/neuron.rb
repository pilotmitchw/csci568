require_relative 'axon'

#Neuron - models the neuron of an ANN
#A neuron can have many input and many output weights
class Neuron

	def initialize( bias = 0.0 )
		@inputs = []
		@outputs = []
		@input_value = 0
		@bias = 0.0
	end
	
	def connect_input( input_axon )
		if(input_axon.class == Axon)
			@inputs << input_axon
			return true
		end
		return false
	end
	
	def connect_output( output_axon )
		if(output_axon.class == Axon)
			@outputs << output_axon
			return true
		end
		
		return false
	end
	
	def set_bias ( bias )
		@bias = bias
	end
	


end