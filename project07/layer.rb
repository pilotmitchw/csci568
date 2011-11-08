#Layer - models a layer of an ANN; the input, output, and hidden layers.
class Layer
	
	def initialize( neurons = [] )
		@neurons = neurons
	end

	def add_neuron( neuron )
		if neuron.class == Neuron
			@neurons << neuron
		end
	end
	
	def evaluate
		@neurons.each do |neuron|
			neuron.evaluate
		end
	end
	
	def clear
		@neurons = []
	end
	
	def get_neurons
		return @neurons
	end
	
	def backpropogate (error)
		#For each layer, we want to reduce the error for this layer based on the error estimated for the previous layer.
		layer.get_neurons.each do |neuron|
			#We want to make the weights of each input axon neuron better by bringing the weights closer to the optimum. (Minimal error)
			
			
			end
	end
end