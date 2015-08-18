require 'json'
require 'open-uri'
require 'pry'

class EtsyScraper

	BASE_URL = "https://openapi.etsy.com/v2/listings/active?api_key=bzamv4eqboevoepjmw7vza6g"

	attr_accessor
	attr_reader :username

	def initialize(username)
		@username = username
	end

# Class Methods

	def get_url
		
	end

	def get_json(url)
    	JSON.load(open(url))
  	end

	def get_most_used_material(desription_hash)
  		
  	end

end