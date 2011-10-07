class DataObject
	attr_accessor :attributes, :class_name
	def initialize(attributes, class_name)
		@attributes = attributes
		@class_name = class_name
	end
	
	def print
		puts "Name = #{@attributes[0]}, class = #{@attributes[1]}"
	end
	
end

def read_file(file_name)
	data_objects = []
	file = File.new(file_name, "r")
	while(line = file.gets)
		split_line = line.split(',')
		
		formatted_split_line = []
		class_name = ""
		
		split_line.each do |part|
			if(part.eql?(" +") or part.eql?("+") or part.eql?("-"))
				class_name = part
			else
				formatted_split_line << part
			end
		end
		data_objects << DataObject.new(formatted_split_line, class_name)
	end
	
	return data_objects
end

def write_file(data_objects, file_name)
	file = File.new(file_name, "w")
	
	data_objects.each do |object|
		file.puts "#{object.attributes[0].strip},#{object.attributes[1].strip},#{object.attributes[2].strip}"
	end
end

data_objects = read_file("winners_losers.csv")

vowels = ["a", "e", "i", "o", "u" ]

data_objects.each do |object|
	if(vowels.include?(object.attributes[0][1])) #Checks the first letter of the first name (second character in whole name)
		object.attributes << "winner"	#if it's a vowel, the name is a winner
	else
		object.attributes << "loser"	#otherwise, it's a loser
	end
end

#Summary
total = 0
correct = 0
incorrect = 0

#Assemble all our totals
data_objects.each do |object|

	#renaming for readability
	actual_class = object.attributes[1]
	predicted_class = object.attributes[2]

	total += 1
	
	if(predicted_class.eql?("winner") and  actual_class.strip =~ /[\s]*\+[\s]*/)
		correct += 1
	elsif(predicted_class.eql?("loser") and actual_class.strip =~ /[\s]*\-[\s]*/)
		correct += 1
	else
		incorrect += 1
		puts "Predicted class was #{predicted_class} when Actual class was #{actual_class}!"
	end
	
end

#Print the summary
puts "Total instances: #{total}"
puts "Correct predictions: #{correct}"
puts "Incorrect predictions: #{incorrect}"
puts "Success rate: #{correct.to_f/total}"

#Write to CSV so we can use WEKA or KNIME to run some Data Mining techniques.
write_file(data_objects, "winners_losers_second_letter.csv")