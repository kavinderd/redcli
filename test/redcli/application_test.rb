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
      stdout.rewind
      assert_match /1\)/, stdout.each_line.first
      9.times { stdout.each_line.next }
      assert_match /\(q\)uit/, stdout.each_line.next
    end
  end

end
