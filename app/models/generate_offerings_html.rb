require "date"

class GenerateHTML

    FILE_COUNTER = 0

	attr_reader(:title, :price, :quantity, :image, :id, :quick_details)

	def initialize(materials, shop_id)
		@mc = materials #materials and their counts
		@materials = [materials[0][0],materials[1][0],materials[2][0]]
		@shop_id = shop_id
	end

	def get_data
	@all_sections = []

		@materials.each do |name|
		section_title = "<h1>#{name.upcase}</h1><hr><hr>"
		@section = [section_title]
		@blocks = []
		@data = Price.new(name)
			@data.get_prices.each do |offer|
				@title = offer[:title]
				@price = offer[:price]
				@quantity = offer[:quantity]
				@image = offer[:image]
				@url = offer[:url]
				# binding.pry
				quick_details_arr = offer[:quick_details] 
				@quick_details = ""
				quick_details_arr.each do |detail|
					@quick_details << "<li>#{detail}</li>"
				end

				# binding.pry
				data_block = "<a class=\"flex-item\" href=\"#{@url}\" target=\"_blank\"> 
								<div>
									<h2>#{title}</h2>
									<hr>
								    <center><img src=\"#{@image}\" /></center>
	         					    <h5 id=\"price_qty\">Price:</h5>
								    <div id=\"price\">#{@price}</div>
								    <div id=\"quantity\">#{@quantity}</div>
							        <h5 id=\"quick_details\">Quick Details:</h5>
							        <ul>#{@quick_details}</ul>
							    </div>
							  </a>"
	
				@blocks << data_block
				@section << @blocks
			end
		@all_sections << @section
		end
		# binding.pry
		date = Date.today
		report_date = "#{date.month}.#{date.day}.#{date.year}"
		materials_used = "<strong>#{@mc[0][0]}</strong>  (#{@mc[0][1]})| <strong>#{@mc[1][0]}</strong> (#{@mc[1][1]})| <strong>#{@mc[2][0]}</strong> (#{@mc[2][1]})"

		report_stats = "<div class=\"flex-container report_stats\">
							<div class=\"shop_name\"><strong>Shop:</strong>   #{@shop_id.capitalize}</div>
							<div class=\"mat_used\"><strong>Most Used Materials:</strong>   #{materials_used}</div>
							<div class=\"as_of_date\"><strong>As of:</strong>   #{report_date}</div>
						</div>"
						
	    file_name = "supply_reports/suso_#{@shop_id}_#{date.year}-#{date.month}-#{date.day}.html"
	    file = File.open(file_name, "w+")
	    

	    file.write("<link rel=\"stylesheet\" href=\"../css/reports.css\">
	    			<link href=\'http://fonts.googleapis.com/css?family=Reenie+Beanie\' rel=\'stylesheet\' type=\'text/css\'>
                   <link href=\'http://fonts.googleapis.com/css?family=Josefin+Sans:700,400|Quicksand\' rel=\'stylesheet\' type=\'text/css\'>")
	    file.write("<ul class=\"colorbar\">
				    <li></li>
				    <li></li>
				    <li></li>
				    <li></li>
				    <li></li>
				    <li></li>
				    <li></li>
				    <li></li>
				    <li></li>
				    <li></li>
				    </ul>

<div class=\"page_title\">
<center><div class=\"suso\">SuSo</div></center>
<center><div class=\"subtitle\">Etsy Supply Sourcer by BurMa</span></center>
</div>")
	    file.write(report_stats)
	    #Write sections and offers

	    container_open = "<div class=\"flex-container\">"
	    container_close = "</div>"

		@all_sections.each do |mdata|
			file.write(mdata[0])	
			file.write(container_open)
			mdata[1].each do |mblock|
				file.write(mblock)
			end
			file.write(container_close)
		end

		file.close 
		`open #{file_name}`
	end #ends method


end
