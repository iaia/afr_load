# AfrLoad

午後ローサイトのスクレイピング

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'afr_load'
```

install it yourself as:

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
        # program.movie_director    #=> 監督
        # program.leading_actor     #=> 主演俳優 
        # program.supporting_actor  #=> 助演俳優 
    end

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iaia/afr_load. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

