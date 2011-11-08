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
	
	
end