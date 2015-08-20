require "pry"

class EtsyMaterialCLI

	attr_accessor :input,:shop_id,:shop_materials,:most_used,:gen_html
	
	def initialize
		puts ""
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
			puts ""
			puts "Invalid command.  Type help to see a list of commands."
			get_command
		end	
	end

	def new_command
		puts ""
		puts "Type and new command.  To see a list of commands, type help."
		get_command
	end

	def help
		puts ""
		puts "Commands:"
		puts "	help       - Shows list of commands."
		puts "	materials  - Returns the top materials used in a shop."
		puts "	exit       - Leaves program."
		puts ""
		get_command
	end

	def invalid_shop 
		puts ""
		puts "Sorry, invalid shop ID. Please retry."
		materials
	end

	def invalid_command
		puts
		puts "Invalid command.  Please type yes or no."
	end

	def materials
		puts ""
		puts "What is your shop ID?"
		@shop_id = gets.chomp.downcase
		@shop_materials = Materials.new(shop_id)
		@most_used = shop_materials.most_used
		if shop_materials.listings.nil?
			return invalid_shop
		elsif most_used.nil?
			new_command
		else
			shop_materials.print_most_used
			search_alibaba?
		end
	end

	def search_alibaba?
		puts "Would you like a list of the lowest prices on Alibaba?"
		@input = gets.chomp.downcase
		if input == "yes" || input == "y"
			generate_html
		elsif input == "no" || input == "n"
			exit_program?
		else
			invalid_command
			search_alibaba?
		end
	end

	def generate_html
		@gen_html = GenerateHTML.new(most_used,@shop_id)
		@gen_html.get_data
	end

	def exit_program?
		puts
		puts "Would you like to exit the program?"
		@input = gets.chomp.downcase
		if input == "yes" || input == "y"
			exit
		elsif input == "no" || input == "n"
			new_command	
		else
			invalid_command
		end
	end

	def exit
		puts ""
		puts "Goodbye!  Have a great day!"
		puts ""
	end

end