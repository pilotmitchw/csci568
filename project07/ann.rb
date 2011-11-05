require 'layer.rb'
require 'axon.rb'
require 'neuron.rb'

#ANN - models the entire neural network
class ANN

	def initialize
		#Try a perceptron first, the one in the book, page 247
		
		#Three input nodes
		
		@input_one = new Neuron
		@input_two = new Neuron
		@input_three = new Neuron
		
		#The perceptron node with bias factor 0.4
		@perceptron = new Neuron(0.4)
		
		#The output node
		@output_one = new Neuron
		
		#Three axons with weight 0.3 from inputs to perceptron
		@input_one_to_p = new Axon(@input_one, @perceptron, 0.3)
		@input_two_to_p = new Axon(@input_two, @perceptron, 0.3)
		@input_three_to_p = new Axon(@input_three, @perceptron, 0.3)
		
		#One axon with weight 1.0 from perceptron to output
		@p_to_output_one = new Axon(@perceptron, @output_one, 1.0)
	end
	
end