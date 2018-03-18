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
                @total = 1
                if api_response['value']
                    facts_array = [api_response]
                else
                    facts_array = api_response['result']
                    @total = api_response[:total]
                end
                @facts = Kaminari.paginate_array(facts_array).page(params[:page]).per(5)
			}

		end

    end
    
end
