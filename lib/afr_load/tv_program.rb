# encoding: utf-8

module AfrLoad
    module TvProgram
        class TvProgram
            attr_accessor :on_air_date,
                :title_ja, :title,
                :released_year, :released_country,
                :leading_actor, :supporting_actor
            def initialize(on_air_date:, title_ja:, title:,
                          released_year:, released_country:,
                          leading_actor:, supporting_actor:)
                @on_air_date = on_air_date
                @title_ja = title_ja
                @title = title
                @released_year = released_year
                @released_country = released_country
                @leading_actor = leading_actor
                @supporting_actor = supporting_actor
            end
        end
    end
end
