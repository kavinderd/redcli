require 'faraday'
require 'json'

module Redcli
  class Application

    ROOT = "http://www.reddit.com"

    def initialize(subreddit:, stdout:STDOUT, stdin: STDIN)
      @subreddit = subreddit
      @stdout = stdout
      @stdin = stdin
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
          @stdout.puts "#{i+1}) #{link["data"]["title"]}"
        end
        prompt_user(:links)
        input = @stdin.gets.chomp
        valid_input = false
        parse_links_input(input, links)
      else
        @stdout.puts "Sorry, no data available"
      end
    end

    def prompt_user(type=:links)
      if type == :links
        @stdout.puts "(1-10) for more information, (q)uit"
      else
        @stdout.puts "(o)pen in browser, (q)uit"
      end
    end

    def parse_links_input(input, links)
      if input =~ /[0-9]/
        link = links[input.to_i - 1]
        display_link(link)
        prompt_user(:link)
        input = @stdin.gets.chomp
        parse_link_input(input, link, links) 
      elsif input == 'q'
        return
      else
      puts "Invalid input"
      prompt_user(links)
      input = STDIN.gets.chomp
      parse_links_input(input, links)
      end 
    end

    def display_link(link)
      if link["data"]["selftext"] != ""
        puts link["data"]["selftext"]
      else
        puts "Topic Url: #{link["data"]["url"]}"
      end
    end

  end
end
