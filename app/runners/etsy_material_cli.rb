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
		end	
	end

	def help
		puts "Commands:"
		puts "	help       - Shows list of commands."
		puts "	materials  - Returns the top materials used in a shop."
		puts "	exit       - Leaves program."
		get_command
	end

	def materials
		runner
	end

	def exit
		puts "Goodbye!"
	end


	def get_shop_id
		puts "What is your shop ID?"
		shop_id = gets.chomp
		shop_id.downcase
	end

	def runner 
		shop_id = get_shop_id
		Materials.new(shop_id).listings
		binding.pry
	end

end