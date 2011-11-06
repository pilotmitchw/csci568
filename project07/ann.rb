require_relative 'layer'
require_relative 'axon'
require_relative 'neuron'

#ANN - models the entire neural network
class ANN
	
	def random_weight
		result = Random.rand
		sign = Random.rand(1)
		
		if(sign == 0)
			result = (-1.0)*result
		end
		
		return result
	end
	
	def initialize
		@layers = []
		
		#Input layer
		#Three input nodes in one layer
		@input_one = Neuron.new
		@input_two = Neuron.new
		@input_three = Neuron.new
		@input_layer = Layer.new
		
		@input_layer.add_neuron(@input_one)
		@input_layer.add_neuron(@input_two)
		@input_layer.add_neuron(@input_three)
		
		@layers << @input_layer
		
		#Two nodes in a hidden_layer
		@hidden_layer = Layer.new
		@hidden_one = Neuron.new
		@hidden_two = Neuron.new
		@layers << @hidden_layer
		
		#Connections from input layer to hidden layer
		@input_one_to_hidden_one = Axon.new(@input_one, @hidden_one, random_weight)
		@input_one_to_hidden_two = Axon.new(@input_one, @hidden_two, random_weight)
		@input_two_to_hidden_one = Axon.new(@input_two, @hidden_one, random_weight)
		@input_two_to_hidden_two = Axon.new(@input_two, @hidden_two, random_weight)
		@input_three_to_hidden_one = Axon.new(@input_three, @hidden_one, random_weight)
		@input_three_to_hidden_two = Axon.new(@input_three, @hidden_two, random_weight)
		
		#Three nodes in the output layer
		@output_layer = Layer.new
		@output_one = Neuron.new
		@output_two = Neuron.new
		@output_three = Neuron.new
		@layers << @output_layer
		
		#Connections from hidden layer to output layer
		@hidden_one_to_output_one = Axon.new(@hidden_one, @output_one, random_weight)
		@hidden_one_to_output_two = Axon.new(@hidden_one, @output_two, random_weight)
		@hidden_one_to_output_three = Axon.new(@hidden_one, @output_three, random_weight)
		@hidden_two_to_output_one = Axon.new(@hidden_two, @output_one, random_weight)
		@hidden_two_to_output_two = Axon.new(@hidden_two, @output_two, random_weight)
		@hidden_two_to_output_three = Axon.new(@hidden_two, @output_three, random_weight)
		
	end
	
	
	def load_inputs(input_one, input_two, input_three )
		@input_one.set_value (input_one)
		@input_two.set_value (input_two)
		@input_three.set_value (input_three)
	end
	
	def evaluate
	
		@layers.each do |layer|
			layer.evaluate
		end
		
		return "Output 1 was: #{@output_one.get_value}"
		return "Output 2 was: #{@output_two.get_value}"
		return "Output 3 was: #{@output_three.get_value}"
	end
end