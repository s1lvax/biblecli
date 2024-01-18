require 'httparty'
require 'json'

RANDOM_BIBLE_VERSE = "https://bible-api.com/?random=verse"
SPECIFIC_BIBLE_VERSE = "https://bible-api.com/"

#Https request
def request(url)
  response = HTTParty.get(url)
  data = JSON.parse(response.body)
end

#Format the fetched data
def format_text(data)
    #Extract the data we want to show
    reference = data['reference']
    text = data['text']
    translation = data['translation_name']
  
    # Formatting output
    formatted_output = <<~HEREDOC
      \033[1mReference:\033[0m #{reference}
      \033[1mTranslation:\033[0m #{translation}
      \033[1mVerse:\033[0m #{text}
    HEREDOC
end

#If no arguments are provided
def get_random_verse()
  data = request(RANDOM_BIBLE_VERSE)
  puts format_text(data)
end

#If specific verse is provided
def get_specific_verse(verse)
  data = request(SPECIFIC_BIBLE_VERSE + verse)
  puts format_text(data)
end

if ARGV.empty?
  get_random_verse()
else
  #first argument
  get_specific_verse(ARGV[0])
end