require 'json'
require 'open-uri'
require 'pry'
require 'nokogiri'
require "awesome_print"

class Prices


  def initialize(material)
     @material = material.gsub(" ", "+")
  end

  def get_data
  	 @url = "http://www.alibaba.com/trade/search?fsb=y&IndexArea=product_en&CatId=&SearchText=#{@material}"
  	 @prices_url = open(@url).read
  	 @alibaba = Nokogiri::HTML(@prices_url)
  end

  def offerings
  	get_prices
  	@offerings = @top_five
  end
  
  # File.write('temp',prices_url)


  # # readPrices = File.read('temp')
  # alibaba = Nokogiri::HTML(prices_url)
  # binding.pry
  def get_prices
  		get_data
	    @top_five = []
	    counter = 0

	    until @top_five.count == 5
	  		offering = @alibaba.css('div[data-ctrdot] .content')[counter] 	
		   	if offering.css("div.attr").text.include? "FOB"
		   		@top_five << offering
		   	end
		   		# binding.pry
		   	counter += 1
		end


		@offers = []
		@top_five.each do |offering|
		    if offering.css("div.attr").text.include? "FOB"

			        title = offering.css("h2").text.gsub(/\s{2,}/, "")
			        offer = {}
			        @offers[title] = title

					offering.css('div.attr').each do |attribute|
					    if attribute.text.include? "FOB"
					  		price_attr = attribute.text.gsub(/\s{2,}/, "")
					  		@offers[:price] = price_attr
					  	elsif attribute.text.include? "Order"
					  		order_attr = attribute.text.gsub(/\s{2,}/, "")
					  		@offers[:quantity] = order_attr
					  	end
					end
					

				details = offering.css(".kv-prop").text.delete("\r").gsub("\t", "").split("\n")
				details.shift
				details.each do |string|
					#make words before colon upcase
					colon = string.index(":")
					string[0..colon] = string[0..colon].upcase
					if string.include? ","
						string.gsub!(/,/, ", ")
					end
				end
				@offers[:Quick_Details] = details

			end
		end
		ap @offers
	end

# \s{2,}

end

prices = Prices.new("hemp")
binding.pry



  	# binding.pry
  	# only collect offerings  that offering.div.attr
  	# div.attr
  	# if offering.text.include? "FOB"
  	# 	puts offering.text
  	# end
  	# puts offering.at_xpath("*")["data-pid"]

  	# binding.pry
    
  	
  	# if offering.css("div.attr").text.include? "FOB"
  	# puts offering.css("h2").text 
  	# attributes = offering.css("div.attr").text.gsub(/\s{2,}/, "")
   #  end