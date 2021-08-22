require 'oauth'
require 'uri'
require 'json'

consumer_key = ENV['TWEE_CONSUMER_KEY']
consumer_secret = ENV['TWEE_CONSUMER_SECRET']

oauth = OAuth::Consumer.new(
  consumer_key,
  consumer_secret,
  site: 'https://twitter.com',
  # debug_output: true,
)

if ENV['TWEE_ACCESS_TOKEN'] && ENV['TWEE_ACCESS_TOKEN_SECRET']
  hash = { oauth_token: ENV['TWEE_ACCESS_TOKEN'], oauth_token_secret: ENV['TWEE_ACCESS_TOKEN_SECRET']}
  access_token = OAuth::AccessToken.from_hash(oauth, hash)
else
  request_token = oauth.get_request_token
  puts request_token.authorize_url

  puts  "Please access this URL      : #{request_token.authorize_url}"
  print "Please enter the PIN code   : "
  pin_code = gets.to_i

  access_token = request_token.get_access_token(
    oauth_verifier: pin_code
  )
  puts "Access Token        : #{access_token.token}"
  puts "Access Token Secret : #{access_token.secret}"
end

message = "test3"

res = access_token.post('https://api.twitter.com/1.1/statuses/update.json?status=' + URI.encode_www_form_component(message))
puts res.code
# pp JSON.parse(res.body)
