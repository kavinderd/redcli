require_relative "../../lib/redcli/application"
require 'minitest/autorun'
require 'pry'
require 'pry-debugger'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :fakeweb
end

class ApplicationTest < Minitest::Test

  def test_viewing_subreddit_links_and_quitting
    VCR.use_cassette("test") do
      stdout = StringIO.new
      stdin = StringIO.new("q\n")
      app = Redcli::Application.new(subreddit: 'test', stdout: stdout, stdin: stdin)
      app.run
      output = stdout.string.split("\n")
      assert_match /1\)/, output[1]
      assert_match /\(q\)uit/, output.last
    end
  end

  def test_viewing_a_subreddit_topic
    VCR.use_cassette("test") do
      stdout = StringIO.new
      stdin = StringIO.new("1\nq\n")
      app = Redcli::Application.new(subreddit: 'test', stdout: stdout, stdin: stdin)
      app.run
      last_line = stdout.string.split("\n").last
      assert_match /\(b\)ack/, last_line
      assert_match /\(q\)uit/, last_line
    end
  end

end
