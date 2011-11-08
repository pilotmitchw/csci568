require_relative 'axon'

#Neuron - models the neuron of an ANN
#A neuron can have many input and many output weights
class Neuron

	def initialize( bias = 0.0 )
		@inputs = []
		@outputs = []
		@output_value = 0.0;
		@bias = bias
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
	
	def get_value
		return @output_value
	end
	
	def set_value (output_value)
		@output_value = output_value
	end
	
	def get_inputs
		return @inputs
	end
	
	#To evaluate, a Neuron will sum up the values of all its inputs, subtracts its
	#bias factor, and decides what to output.
	
	#For now, a Neuron will output 1 if the result of the above calculation is positive
	#and -1 if the result is negative.
	def evaluate
	
		total = 0.0
		@inputs.each do |input|
			total = total + input.get_value
		end
		
		total = total - @bias
		
		#puts "Node total was #{total}"
		
		if(total > 0.0)
			output = 1.0
		elsif (total < 0.0)
			output = -1.0
		else
			output = 0.0
		end
	
	
		@output_value = output
	
	end


end