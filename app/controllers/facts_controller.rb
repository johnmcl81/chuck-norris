class FactsController < ApplicationController
    skip_before_action :verify_authenticity_token
    require 'http'

    def index
        api_response =HTTP::ApiConsumer.new('https://api.chucknorris.io/jokes/categories',{}).get_response
        @categories = api_response
    end

    def search

        if params[:text] != ''
            url = 'https://api.chucknorris.io/jokes/search'
            query = {query: params[:text]}
        else
            url = 'https://api.chucknorris.io/jokes/random'
            query = {category: params[:category] }
        end 
 
        respond_to do |format|
			format.js {
                api_response =HTTP::ApiConsumer.new(url,query).get_response
                puts api_response
                if api_response['value']
                    @facts = [api_response]
                else
                    @facts = api_response['result']
                end
			}

		end

    end
    
end
