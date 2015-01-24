require 'faraday'
require 'json'
require 'colorize'

module Redcli
  class Application

    ROOT = "http://www.reddit.com"
    COLORS = [:white, :yellow]

    def initialize(subreddit:, stdout:STDOUT, stdin: STDIN)
      @subreddit = subreddit
      @stdout = stdout
      @stdin = stdin
    end

    def run
      @links = get_links
      if @links
        links
      else
        signal_failure
      end
    end

    def links
      display_links
      prompt_links_input
      act_on_input
    end

    def link(link_index)
      @current_link = @links[link_index]
      display_topic(link_index)
      prompt_link_input
      act_on_input
    end

    def open_current_link
      url = @current_link["data"]["url"]
      `open #{url}`
    end

    private

    def url
      ROOT + "/r/" + @subreddit + ".json"
    end

    def get_links
      response = Faraday.get(url)
      body = JSON.parse(response.body)
      if body
        body["data"]["children"].first(10)
      end
    end

    def signal_failure
      @stdout.puts "Sorry, reddit is either not responding or the subreddit does not exist, try again"
    end

    def display_links
      @stdout.puts "\n"
      @links.each_with_index do |link, i|
        title = link.fetch("data", { "title" => "No Title"}).fetch("title")
        @stdout.puts "#{i+1}) #{title}".send(COLORS[i%2])
      end 
      @stdout.puts "\n"
    end

    def display_topic(topic_index)
      @stdout.puts "\n\n\n"
      @stdout.puts @links[topic_index].fetch("data", { "selftext" => "No Information Available" }).fetch("selftext")
      @stdout.puts "\n"
    end

    def prompt_links_input
      @stdout.puts "(1-10) | (q)uit"
    end

    def prompt_link_input
      @stdout.puts "(b)ack | (q)uit | (o)pen in browser"
    end

    def act_on_input
      input = @stdin.gets.chomp
      if input =~ /q/
        return
      elsif input =~ /[0-9]/
        link(input.to_i - 1)
      elsif input =~ /b/
        links
      elsif input =~ /o/
        open_current_link
      end
    end

  end
end
