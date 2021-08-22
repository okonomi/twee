require 'oauth'
require 'uri'
require 'json'

consumer_key = ENV['TWITTER_CONSUMER_KEY']
consumer_secret = ENV['TWITTER_CONSUMER_SECRET']

oauth = OAuth::Consumer.new(
  consumer_key,
  consumer_secret,
  site: 'https://twitter.com',
  debug_output: true,
)

request_token = oauth.get_request_token
puts request_token.authorize_url

puts  "Please access this URL      : #{request_token.authorize_url}"
print "Please enter the PIN code   : "
pin_code = gets.to_i

access_token = request_token.get_access_token(
  oauth_verifier: pin_code
)

message = "test1\ntest2"

res = access_token.post('https://api.twitter.com/1.1/statuses/update.json?status=' + URI.encode_www_form_component(message))
puts res.code
pp JSON.parse(res.body)
