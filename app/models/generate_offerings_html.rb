require "date"

class GenerateHTML

    FILE_COUNTER = 0

	attr_reader(:title, :price, :quantity, :image, :id, :quick_details)

	def initialize(materials, shop_id)
		@materials = materials
		@shop_id = shop_id
	end

	def get_data
		@all_blocks = []
		@materials.each do |m|
			@data = Price.new(m)
			@data.get_prices.each do |offer|
				@title = offer[:title]
				@price = offer[:price]
				@quantity = offer[:quantity]
				@image = offer[:image]
				# binding.pry
				quick_details_arr = offer[:quick_details] 
				@quick_details = ""
				quick_details_arr.each do |detail|
					@quick_details << "<li>#{detail}</li>"
				end


				data_block =   "<h2>#{title}</h2>
								<hr>
								<div class=\"flex-container\">
								<div class=\"flex-item left\">
								<img src=\"#{@image}\" />
								<div id=\"price\">#{@price}</div>
								<div id=\"quantity\">#{@quantity}</div>
							    </div>
							    <h5 id=\"quick_details\">Quick Details:</h5>
							    <ul>#{@quick_details}</ul>"
	
				@all_blocks << data_block
			end
		end

		date = Date.today
						# binding.pry
	    file_name = "supply_reports/suso_#{@shop_id}_#{date.year}-#{date.month}-#{date.day}.html"
	    file = File.open(file_name, "w+")
	    file.write("<link rel=\"stylesheet\" href=\"../css/reports.css\">")
		@all_blocks.each do |mdata|
			# binding.pry
			file.write(mdata)
		end
		file.close 
		`open #{file_name}`
	end
end

# "suso_#{@shop_id}_#{date.month}-#{date.day}-#{date.year}"