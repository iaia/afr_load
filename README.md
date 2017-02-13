# AfrLoad

午後ローサイトのスクレイピング

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'afr_load'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install afr_load

## Usage

    programs = AfrLoad::AfrLoad.get_schedule()
    programs.each do |program|
        program.show()
        # program.on_air_date       #=> 放送日
        # program.title_ja          #=> 邦題
        # program.title             #=> 原題 
        # program.released_year     #=> 公開年 
        # program.released_country  #=> 公開国(製作国?) 
        # program.leading_actor     #=> 主演俳優 
        # program.leading_actor     #=> 主演俳優 
        # program.supporting_actor  #=> 助演俳優 
    end

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iaia/afr_load. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

