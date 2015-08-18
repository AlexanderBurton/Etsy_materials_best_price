require 'json'
require 'open-uri'
require 'pry'

class EtsyShopInfo

	attr_accessor
	attr_reader :username

	def initialize(shop_id)
		@shop_id = shop_id
		@url = "https://openapi.etsy.com/v2/shops/#{shop_id}/listings/active?api_key=bzamv4eqboevoepjmw7vza6g"
		@listing_hash = JSON.load(open(@url))
	end

	# Class methods

	def listings
		puts @listing_hash
	end

	def get_most_used_material(desription_hash)
		
  		
  	end

end