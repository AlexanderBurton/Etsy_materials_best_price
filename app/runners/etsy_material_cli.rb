class EtsyMaterialCLI

	attr_accessor :input
	
	def initialize
		puts "Welcome to the Etsy material sourcer!"
		puts "To see a list of commands, type help."
		@input = gets_chomp
	end

	def help
		puts "Commands:"
		puts "	help       - Shows list of commands."
		puts "	materials  - Returns the top materials used in a shop."
		puts "	exit       - Leaves program."
	end

	def materials
		runner
	end

	def exit
		
	end


	def get_shop_id
		puts "Welcome, what is your shop ID?"
		shop_id = gets.chomp
		shop_id.downcase
	end

	def runner 
		shop_id = get_shop_id
		get_hash = GetHash.new(shop_id)
		get_hash.listings
	end

end