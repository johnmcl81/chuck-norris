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
                
                search_record = Search.new(text: params[:text], category: params[:category], results: facts_array.map{ |f| f['value'] }&.to_s)
                search_record.save()

                if params[:email]
                    email_text = facts_array.map{ |f| f['value'] }&.join(' \n ').to_s
                    # SearchMailer.send(email_text).deliver
                    ActionMailer::Base.mail(from: "j.d.mclachlan@gmail.com", to: params[:email], subject: "Your Chuck Norris Facts", body: email_text).deliver
                end
			}

		end

    end
    
end
