#Node - models the neuron of an ANN
#A neuron can have many input and many output weights
class Node

	def initialize()
		@inputs = []
		@outputs = []
	end
	
	def add_input( input_node )
		if(input_node.class == Node)
			@inputs << input_node
			return true
		end
		return false
	end
	
	def add_output( output_node )
		if(input_node.class == Node)
			@outputs << output_node
		end
	end


end