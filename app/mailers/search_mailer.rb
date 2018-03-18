class SearchMailer < ApplicationMailer

    def send(facts)
        @facts = facts
        # @email = email
        mail(:to => 'j.d.mclachlan@gmail.com',
             :subject => "Your Chuck Norris Facts")
      end
end
