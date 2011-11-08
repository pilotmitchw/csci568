class TrainingExample
	attr_accessor :one_input, :one_output, :two_input, :two_output, :three_input, :three_output
  def initialize( one_input=0.0, one_output=0.0, two_input=0.0, two_output=0.0, three_input=0.0, three_output=0.0)
		@one_input = one_input
		@one_output = one_output
		@two_input = two_input
		@two_output = two_output
		@three_input = three_input
		@three_output = three_output
	end
	
	def set_expected_inputs( input_one, input_two, input_three )
		@one_input = input_one
		@two_input = input_two
		@three_input = input_three
	end
	
	def set_expected_outputs( output_one, output_two, output_three )
		@one_output = output_one
		@two_output = output_two
		@three_output = output_three
	end
end