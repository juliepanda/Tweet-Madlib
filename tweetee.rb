require 'sinatra'
require 'twitter'
require 'dinosaurus'

CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = #{KEY}
  config.consumer_secret     = #{KEY}
  config.access_token        = #{KEY}
  config.access_token_secret = #{KEY}
end

Dinosaurus.configure do |config|
  config.api_key = #KEY
end

get '/' do
	@tweets = CLIENT.user_timeline.map { |tweet| tweet.text  }
	erb :index
end

post '/tweet' do
	CLIENT.update(rejoiner(params[:tweet]))
	redirect '/'
end


def rejoiner(string)
  string.split(" ").map { |word| get_not_prep(word)}.join(" ")
end

def get_not_prep(word)
  word = word.downcase

  word_ary = ["am", "about", "above", "according to", "across", "after", "against", "along",
    "with", "among", "apart", "around", "as", "for", "at", "because", "of", "be",
     "before", "behind", "below", "beneath", "beside", "between", "beyond", "but",
     "by", "means", "concerning", "despite", "down", "up", "during", "except",
     "from", "in", "instead", "into", "like", "near", "of", "off", "on", "onto",
     "out", "over", "to", "till", "toward", "through", "throughout", "until", "with",
     "within", "without", "toward", "since", "should",
     "under", "underneath", "until", "unlike", "upon", "i", "you", "he", "she",
     "him", "her", "other", "there", "they", "them", "that", "this", "me", "my", "his",
     "hers", "their"]

  val = word_ary.include? word

  val==false ? get_synonym(word) : word
end

def get_synonym(word)
  results = Dinosaurus.synonyms_of(word)
  len = rand(results.length)

  len==0? word : word = results[len]

end
