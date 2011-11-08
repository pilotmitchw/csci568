require_relative 'layer'
require_relative 'axon'
require_relative 'neuron'
require_relative 'trainingexample'

#ANN - models the entire neural network
class ANN
	
	def random_weight
		result = Random.rand
		sign = Random.rand(2)
		
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
		
		puts "Inputs loaded:"
		puts "Input 1: #{@input_one.get_value}"
		puts "Input 2: #{@input_two.get_value}"
		puts "Input 3: #{@input_three.get_value}"
		
		#@input_one.evaluate
		#@input_two.evaluate
		#@input_three.evaluate
		
		#puts "Inputs loaded:"
		#puts "Input 1: #{@input_one.get_value}"
		#puts "Input 2: #{@input_two.get_value}"
		#puts "Input 3: #{@input_three.get_value}"
		
	end
	
	def evaluate
		feed_forward
		
		#To prove input gets all the way to the end of the operation
		#puts "Input 1: #{@input_one.get_value}"
		#puts "Input 2: #{@input_two.get_value}"
		#puts "Input 3: #{@input_three.get_value}"
	
		
		puts "Output 1 was: #{@output_one.get_value}"
		puts "Output 2 was: #{@output_two.get_value}"
		puts "Output 3 was: #{@output_three.get_value}"
		
		return true
	end
	
	def train (training_example, max_iterations)
		iterations = 0
		while(iterations < max_iterations)
			iterations += 1
			feed_forward
			backpropogate(training_example)
		end
	end
	
	def feed_forward
		@hidden_one.evaluate
		@hidden_two.evaluate
		@output_one.evaluate
		@output_two.evaluate
		@output_three.evaluate
	end
	
	def backpropogate_for_output_neuron(neuron, expected, learning_rate)
		inputs = neuron.get_inputs
		prediction_error = 0.0
		inputs.each do |input|
			prediction_error = expected - neuron.get_value
			
			#Change the strength of every incoming link in proportion to the link's current strength and the learning rate
			new_weight = input.get_weight + learning_rate*(prediction_error)*input.get_value
			#puts "#{new_weight} = #{input.get_weight} + #{learning_rate}(#{prediction_error})(#{input.get_value})"
					
			input.set_weight(new_weight)
			
			return prediction_error
				
		end
	end
	
	def backpropogate_for_hidden_neuron(neuron, ea, learning_rate)
		inputs = neuron.get_inputs
			
		inputs.each do |input|
			prediction_error = ea
			
			#Change the strength of every incoming link in proportion to the link's current strength and the learning rate
			new_weight = input.get_weight + learning_rate*(prediction_error)*input.get_value
			#puts "#{new_weight} = #{input.get_weight} + #{learning_rate}(#{prediction_error})(#{input.get_value})"
					
			input.set_weight(new_weight)
			
			return prediction_error
				
		end
	end
	
	
	def backpropogate(training_example)
		#We treat the output layer seperately than the hidden layer because we know the values that the output layer is supposed to have.
		#From 'Programming Collective Intelligence'
		#For each node in the output layer	
		#Calculate the difference between the node's current output and what it should be
		#(from http://www.doc.ic.ac.uk/~nd/surprise_96/journal/vol4/cs11/report.html)
		
		learning_rate = 0.1
		
		#The algorithm computes each EW by first computing the EA, the rate at which the error changes as the activity level of a unit is changed. For output units, the EA is simply the difference between the actual and the desired output.
		
		#output_one
		output_one_EA = backpropogate_for_output_neuron(@output_one, training_example.one_output, learning_rate)
		#output_two
		output_two_EA = backpropogate_for_output_neuron(@output_two, training_example.two_output, learning_rate)
		#output_three
		output_three_EA = backpropogate_for_output_neuron(@output_three, training_example.three_output, learning_rate)
		
		
		#To compute the EA for a hidden unit in the layer just before the output layer, we first identify all the weights between that hidden unit and the output units to which it is connected. We then multiply those weights by the EAs of those output units and add the products. This sum equals the EA for the chosen hidden unit. After calculating all the EAs in the hidden layer just before the output layer, we can compute in like fashion the EAs for other layers, moving from layer to layer in a direction opposite to the way activities propagate through the network.
		#(from http://www.doc.ic.ac.uk/~nd/surprise_96/journal/vol4/cs11/report.html)
		
		
		#hidden_one
		#Identify all the weights between hidden_one and outputs
		weight_one = @hidden_one_to_output_one.get_weight
		weight_two = @hidden_one_to_output_two.get_weight
		weight_three = @hidden_one_to_output_three.get_weight
		
		#Multiply those weights by the EAs of those output units
		multiplied_one = weight_one * output_one_EA
		multiplied_two = weight_two * output_two_EA
		multiplied_three = weight_three * output_three_EA
		
		#Sum the products
		summed_products = multiplied_one + multiplied_two + multiplied_three
		
		#This equals the EA for the chosen hidden unit.
		#Should be able to use the same process, then, as the hidden units use
		hidden_one_EA = backpropogate_for_hidden_neuron(@hidden_one, summed_products, learning_rate)
		
		
		#hidden_two
		#Identify all the weights between hidden_two and outputs
		weight_one = @hidden_two_to_output_one.get_weight
		weight_two = @hidden_two_to_output_two.get_weight
		weight_three = @hidden_two_to_output_three.get_weight
		
		#Multiply those weights by the EAs of those output units
		multiplied_one = weight_one * output_one_EA
		multiplied_two = weight_two * output_two_EA
		multiplied_three = weight_three * output_three_EA
		
		#Sum the products
		summed_products = multiplied_one + multiplied_two + multiplied_three
		
		#This equals the EA for the chosen hidden unit.
		#Should be able to use the same process, then, as the hidden units use
		hidden_two_EA = backpropogate_for_hidden_neuron(@hidden_two, summed_products, learning_rate)
	end

end