class SsrfController < ApplicationController
 def index
   conn = Faraday.new("https://api.github.com/users/")
   username = params[:username]
   resp = conn.get(username, {}, fake_authorization: "Bearer my_secret_token") 
   render plain: "GET #{resp.env.url} with headers #{resp.env.request_headers} returned:\n\n#{resp.body}"
 end
end
