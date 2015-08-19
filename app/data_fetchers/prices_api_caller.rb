require 'json'
require 'open-uri'
require 'pry'
require 'nokogiri'

class Prices

	attr_reader :materials

	def initialize(materials)
		@materials = materials
	end

	def find_products
		htmls = []
		@materials.each do |product|
			htmls << open("http://www.alibaba.com/trade/search?fsb=y&IndexArea=product_en&CatId=&SearchText=#{product}")
		end
		first_alibaba = Nokogiri::HTML(htmls[0])
		second_alibaba = Nokogiri::HTML(htmls[1])
		third_alibaba = Nokogiri::HTML(htmls[2])
	end
	

end