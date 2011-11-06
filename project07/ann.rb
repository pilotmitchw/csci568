require_relative 'layer'
require_relative 'axon'
require_relative 'neuron'

#ANN - models the entire neural network
class ANN

	def initialize
		#Try a perceptron first, the one in the book, page 247
		
		#Three input nodes
		
		@input_one = Neuron.new
		@input_two = Neuron.new
		@input_three = Neuron.new
		
		#The perceptron node with bias factor 0.4
		@perceptron = Neuron.new(0.4)
		
		#The output node
		@output_one = Neuron.new
		
		#Three axons with weight 0.3 from inputs to perceptron
		@input_one_to_p = Axon.new(@input_one, @perceptron, 0.3)
		@input_two_to_p = Axon.new(@input_two, @perceptron, 0.3)
		@input_three_to_p = Axon.new(@input_three, @perceptron, 0.3)
		
		#One axon with weight 1.0 from perceptron to output
		@p_to_output_one = Axon.new(@perceptron, @output_one, 1.0)
	end
	
	
	def load_inputs(input_one, input_two, input_three )
		@input_one.set_value (input_one)
		@input_two.set_value (input_two)
		@input_three.set_value (input_three)
	end
	
	def evaluate
		@perceptron.evaluate
		#puts "Output of perceptron node was: #{@perceptron.get_value}"
		
		@output_one.evaluate
		
		return "Output was: #{@output_one.get_value}"
	end
end