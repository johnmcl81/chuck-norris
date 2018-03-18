module HTTP
	class ApiConsumer

		def initialize(url, query)
			@url = url
			@query = query
		end

		def get_response
			puts "GET URL #{@url}"
			puts "GET DATA #{@query}"
			parsed_response = nil
			begin
				http_response = HTTParty.get(@url, :query => @query)
			rescue Timeout::Error => error
				puts "Timeout Error #{error}"
			rescue HTTParty::Error => e
				puts "HttParty Error #{e.message}"
			rescue StandardError => e
				puts "StandardError Error #{e.message}"
			else
				if http_response.code == 200
					parsed_response = http_response.parsed_response
				else
					puts "Response Error #{http_response.code}"
				end
			end
			parsed_response
		end

		def post_response
			puts "POST URL #{@url}"
			puts "POST DATA #{@query}"
			parsed_response = nil
			begin
				http_response = HTTParty.post(@url, {body: @query.to_json, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}})
			rescue Timeout::Error => error
				puts "Timeout Error #{error}"
			rescue HTTParty::Error => e
				puts "HttParty Error #{e.message}"
			rescue StandardError => e
				puts "StandardError Error #{e.message}"
			else
				if http_response.code == 200
					parsed_response = http_response.parsed_response
				else
					puts "Response Error #{http_response.code}"
				end
			end
			parsed_response
		end

	end
end
