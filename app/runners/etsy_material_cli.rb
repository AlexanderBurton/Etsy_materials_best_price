require "pry"

class EtsyMaterialCLI

	attr_accessor :input
	
	def initialize
		puts "Welcome to the Etsy material sourcer!"
		puts "To see a list of commands, type help."
		get_command					
	end

	def get_command
		@input = gets.chomp.downcase
		if input == "help"
			help
		elsif input == "materials"
			materials
		elsif input == "exit"
			exit
		else
			puts "Invalid command.  Type help to see a list of commands."
			get_command
		end	
	end

	def help
		puts "Commands:"
		puts "	help       - Shows list of commands."
		puts "	materials  - Returns the top materials used in a shop."
		puts "	exit       - Leaves program."
		get_command
	end

	def invalid 
		puts "Sorry, invalid shop ID. Please retry."
		materials
	end

	def materials
		puts "What is your shop ID?"
		shop_id = gets.chomp.downcase
		@shop_materials = Materials.new(shop_id)
		if @shop_materials.listings.nil?
			return invalid
		else
			@shop_materials.most_used
		end
		puts "Would you like me to find sites that sell these items?"

	end

	def exit
		puts "Goodbye!"
	end

end