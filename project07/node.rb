require 'axon.rb'

#Node - models the neuron of an ANN
#A neuron can have many input and many output weights
class Node

	def initialize()
		@inputs = []
		@outputs = []
	end
	
	def add_input( input_axon )
		if(input_node.class == Axon)
			@inputs << input_axon
			return true
		end
		return false
	end
	
	def add_output( output_axon )
		if(input_node.class == Axon)
			@outputs << output_axon
		end
	end
	
	


end