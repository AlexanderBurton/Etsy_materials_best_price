require 'json'
require 'open-uri'
require 'pry'

class Materials	
	attr_accessor
	attr_reader :username

	def initialize(shop_id)	
		@shop_id = shop_id
		@url = "https://openapi.etsy.com/v2/shops/#{shop_id}/listings/active?api_key=bzamv4eqboevoepjmw7vza6g"
	end

	def listing_hash
		begin
		JSON.load(open(@url))
	    rescue
	    	return nil
	    else
		@listing_hash = JSON.load(open(@url))
	    end
	end

	def invalid 
		puts "Sorry, invalid shop ID. Please retry."
	end

	def listings
		@listing_hash
	end

	def most_used
		@materials = {}
		@most_used = []
		if listing_hash.nil?
			return invalid
		end
		listing_hash["results"].each do |listing|
			listing["materials"].each do |material|
				if @materials[material].nil?
					@materials[material] = 1
				else 
					@materials[material] += 1
				end
			end
	    end
	    if @materials.empty?
	    	puts "Sorry, your shop does not list materials."
	    	return nil
	    end
	    @materials = @materials.to_a.sort_by do |material_arr| 
	    	material_arr[1] 
	    end
	    @materials.sort! {|a,b| b[1] <=> a[1] }
	    @materials[0..2].each do |material|
	    	@most_used << material[0]
	    end
	    puts ""
	    puts "Hello #{@shop_id.capitalize}, your 3 most used materials are:"
	    puts "1. #{@most_used[0].capitalize}"
	    puts "2. #{@most_used[1].capitalize}"
	    puts "3. #{@most_used[2].capitalize}" 
        puts ""
	    @most_used
	end
end