# Redcli

Redcli is a simple way to view the top 10 posts on any reddit subreddit. I created this gem to create a no-frills reddit experience that will hopefully
reduce it as a distraction. Redcli is not meant to be a comprehensive hookup with Reddit's API but simply fills my needs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redcli'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redcli

## Usage

*View top 10 links in a subreddit*

To view a subreddit, for example '/r/ruby' simple pass the name of the subreddit 'ruby'
```
$ redcli view ruby
> Top 10 Links on /r/ruby:
> 1) Link 1
> 2) Link 2
> 3) Link 3
> 4) Link 4
> 5) Link 5
> ...
> (1-10) for more information on a link or, (n)ew search, (q)uit 
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/redcli/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
