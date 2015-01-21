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
      @links = get_links
      if @links
        display_links
        prompt_action
        act_on_input
      else
        signal_failure
      end
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
      @links.each_with_index do |link, i|
        title = link.fetch("data", { "title" => "No Title"}).fetch("title")
        @stdout.puts "#{i+1}) #{title}"
      end 
    end

    def prompt_action
      @stdout.puts "(q)uit"
    end

    def act_on_input
      input = @stdin.gets.chomp
      if input =~ /q/
        return
      end
    end

  end
end
