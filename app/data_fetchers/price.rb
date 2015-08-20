require 'json'
require 'open-uri'
require 'pry'
require 'nokogiri'

class Price


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
  	@offerings = @top_three
  end


  def get_prices
  		get_data
	    @top_three = []
	    counter = 0

	    until @top_three.count == 3
	  		offering = @alibaba.css('div[data-ctrdot]')[counter] 
		   	if offering.css("div.attr").text.include? "FOB"
		   		@top_three << offering
		   	end
		   	counter += 1
		end


		@offers = []
		@top_three.each do |offering|
			# binding.pry
		    if offering.css("div.attr").text.include? "FOB"
		        title = offering.css("h2").text.gsub(/\s{2,}/, "")
		        @offer = {}
		        @offer[:title] = title

					offering.css('div.attr').each do |attribute|
					    if attribute.text.include? "FOB"
					  		price_attr = attribute.text.gsub(/\s{2,}/, "")
					  		@offer[:price] = price_attr
					  	elsif attribute.text.include? "Order"
					  		order_attr = attribute.text.gsub(/\s{2,}/, "")
					  		@offer[:quantity] = order_attr
					  	end
					end
# binding.pry
				if offering.css("div.image img").attribute("src")!= nil
				@offer[:image] = offering.css("img").attribute("src").text
			    else
			    	@offer[:image] = offering.css("img").attribute("image-src").text
			    end
				@offer[:id] = offering.css("a").attribute("data-hislog").text
				@offer[:url] = offering.css(".title a").attribute("href").value
					
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
				@offer[:quick_details] = details

			end
			@offers << @offer

		end
	    @offers
	end

end

