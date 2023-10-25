class SsrfController < ApplicationController
 def index
   conn = Faraday.new("https://api.github.com/users/")
   username = params[:username].to_s
   raise "invalid username" unless username.match?(/\A[A-Za-z0-9-]+\z/)
   resp = conn.get(username, {}, fake_authorization: "Bearer my_secret_token") 
   render plain: "GET #{resp.env.url} with headers #{resp.env.request_headers} returned:\n\n#{resp.body}"
 end
end
