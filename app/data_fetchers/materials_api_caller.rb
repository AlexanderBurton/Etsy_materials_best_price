require 'json'
require 'open-uri'
require 'pry'
require 'ruby-progressbar'

class Materials	
	attr_accessor
	attr_reader :username

	def initialize(shop_id)	
		@shop_id = shop_id
		@url = "https://openapi.etsy.com/v2/shops/#{shop_id}/listings/active?api_key=bzamv4eqboevoepjmw7vza6g"
	end

	def listings
		begin
		JSON.load(open(@url))
	    rescue
	    	return nil
	    else
		@listing_hash = JSON.load(open(@url))
	    end
	end

	def no_materials
		puts "Sorry, your shop does not list materials."
	end

	def most_used_empty?
		self.most_used && self.most_used.empty?
	end

	def most_used
		@materials = {}
		@most_used = []
		progress = listings["results"].length
		@progress_bar = ProgressBar.create(:total => @progress)
		listings["results"].each do |listing|
			listing["materials"].each do |material|
				if @materials[material].nil?
					@materials[material] = 1
				else 
					@materials[material] += 1
				end
			end
			@progress_bar.increment
	    end
	    if @materials.empty?
	    	return no_materials
	    end
	    @materials = @materials.to_a.sort_by do |material_arr| 
	    	material_arr[1] 
	    end
	    @materials.sort! {|a,b| b[1] <=> a[1] }
	    @materials[0..2].each do |material|
	    	@most_used << material[0]
	    end
	    @most_used
	end

	def print_most_used
		puts ""
		puts "Hello #{@shop_id.capitalize}, your 3 most used materials are:"
		puts "1. #{@most_used[0].capitalize}"
		puts "2. #{@most_used[1].capitalize}"
		puts "3. #{@most_used[2].capitalize}" 
	    puts ""
	end
end