class SsrfController < ApplicationController
 def index
   conn = Faraday.new("https://api.github.com")
   path = "/users/" + params[:username]
   resp = conn.get(path, {}, fake_authorization: "Bearer my_secret_token") 
   render plain: "GET #{resp.env.url} with headers #{resp.env.request_headers} returned:\n\n#{resp.body}"
 end
end
