require 'json'
require 'open-uri'
require 'pry'

class BulkDeals

	BASE_ETSY_URL = "https://openapi.etsy.com/v2/listings/active?api_key=bzamv4eqboevoepjmw7vza6g"

	def get_url(domain)

	end

	def get_json(url)
    	JSON.load(open(url))
  	end

  	def get_most_used_material(desription_hash)
  		
  	end

end