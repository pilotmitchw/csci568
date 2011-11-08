require_relative 'ann'
require_relative 'trainingexample'
#Driver!
puts "Before training:"
ann = ANN.new
ann.load_inputs(1.0, 0.25, -0.5)
result = ann.evaluate
puts result
puts
puts
training_example = TrainingExample.new
ann.load_inputs(1.0, 0.25, -0.5)
training_example.set_expected_inputs( 1.0, 0.25, -0.5 )
training_example.set_expected_outputs( 1.0, -1.0, 0.0 )
ann.train(training_example, 1000)
puts "After training:"
result = ann.evaluate
puts result