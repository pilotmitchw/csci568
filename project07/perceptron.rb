require_relative 'neuron'
require_relative 'axon'

class Perceptron
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
		@output_one.evaluate
		
		puts "Output was #{@output_one.get_value}"
	end
	
	def train(training_example, learning_rate, max_iterations)
		iterations = 0
		
		#randomize weights
		
		while(iterations < max_iterations)
			iterations += 1
			
			@perceptron.evaluate
			@output_one.evaluate
			
			#@perceptron.print
			
			inputs = @perceptron.get_inputs
			
			prediction_error = 0.0
			inputs.each do |input|
				prediction_error = training_example - @perceptron.get_value
				new_weight = input.get_weight + learning_rate*(prediction_error)*input.get_value
				puts "#{new_weight} = #{input.get_weight} + #{learning_rate}(#{prediction_error})(#{input.get_value})"
				
				
				
				input.set_weight(new_weight)
				
			end
			
			if(prediction_error == 0.0)
					break
				end
		end
		
	end
end

perceptron = Perceptron.new
perceptron.load_inputs(0.0, 1.0, 0.0)
perceptron.train(1.0, 0.1, 100)
perceptron.evaluate
puts
puts
puts
puts
puts "NEW"
puts

puts "Training to -1.0----------"
perceptron.load_inputs(1.0, 1.0, 1.0)
perceptron.train(-1.0, 0.1, 100)
perceptron.evaluate