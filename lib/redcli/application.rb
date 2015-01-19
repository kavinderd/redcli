require 'faraday'
require 'json'

module Redcli
  class Application

    ROOT = "http://www.reddit.com"

    def initialize(subreddit:)
      @subreddit = subreddit
    end

    def run
      display_links
    end

    private

    def url
      ROOT + "/r/" + @subreddit + ".json"
    end

    def display_links
      response = Faraday.get(url)
      body = JSON.parse(response.body)
      if body
        links = body["data"]["children"].first(10)
        links.each_with_index do |link, i|
          puts "#{i+1}) #{link["data"]["title"]}"
        end
        prompt_user(:links)
        input = gets.chomp
        valid_input = false
        parse_links_input(input, links)
      else
        puts "Sorry, no data available"
      end
    end

    def prompt_user(type=:links)
      if type == :links
        puts "(1-10) for more information, (q)uit"
      else
        puts "(o)pen in browser, (q)uit"
      end
    end

    def parse_links_input(input, links)
      if input =~ /[0-9]/
        link = links[input.to_i - 1]
        display_link(link)
        promp_user(:link)
        input = gets.chomp
        parse_link_input(input, link, links) 
      elsif input == 'q'
        abort
      else
      puts "Invalid input"
      promp_user(links)
      input = gets.chomp
      parse_links_input(input, links)
      end 
    end

    def diplay_link(link)
      if link["data"]["selftext"] != ""
        puts link["data"]["selftext"]
      else
        puts "Topic Url: #{link["data"]["url"]}"
      end
    end

  end
end
