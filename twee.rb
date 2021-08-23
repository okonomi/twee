require 'oauth'
require 'uri'
require 'json'
require 'yaml/store'

config_path = File.expand_path('./tw.yml')
config = if File.exists?(config_path)
           YAML.load_file(config_path)
         else
          {
            'consumer_key' => ENV['TWEE_CONSUMER_KEY'],
            'consumer_secret' => ENV['TWEE_CONSUMER_SECRET'],
          }
        end

oauth = OAuth::Consumer.new(
  config['consumer_key'],
  config['consumer_secret'],
  site: 'https://twitter.com',
  # debug_output: true,
)

if config['access_token'] && config['access_token_secret']
  hash = { oauth_token: config['access_token'], oauth_token_secret: config['access_token_secret'] }
  access_token = OAuth::AccessToken.from_hash(oauth, hash)
else
  request_token = oauth.get_request_token

  puts  "Please access this URL      : #{request_token.authorize_url}"
  print "Please enter the PIN code   : "
  pin_code = STDIN.gets.to_i

  access_token = request_token.get_access_token(
    oauth_verifier: pin_code
  )
  config['access_token'] = access_token.token
  config['access_token_secret'] = access_token.secret

  store = YAML::Store.new config_path
  store.transaction do
    store['consumer_key'] = config['consumer_key']
    store['consumer_secret'] = config['consumer_secret']
    store['access_token'] = config['access_token']
    store['access_token_secret'] = config['access_token_secret']
  end
end

message = ARGV[0]

res = access_token.post('https://api.twitter.com/1.1/statuses/update.json?status=' + URI.encode_www_form_component(message))
puts res.code
# pp JSON.parse(res.body)
