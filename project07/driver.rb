require_relative 'ann'

#Driver!
ann = ANN.new
ann.load_inputs(0.0, 0.0, 1.0)
result = ann.evaluate

puts result