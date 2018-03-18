class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

	#-----------------------------------------------------------------------------
	def set_locale
		if params[:lang]
			I18n.locale = params[:lang]
		else
			I18n.locale = extract_browser_locale
		end
		@lang = I18n.locale
  end
  
  private

	#-----------------------------------------------------------------------------
	def extract_browser_locale
		if request.env['HTTP_ACCEPT_LANGUAGE'] && request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first == 'es'
			'es'
		else
			'en'
		end
	end
end
