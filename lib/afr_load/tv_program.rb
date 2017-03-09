# encoding: utf-8

module AfrLoad
    class TvProgram
        attr_accessor :on_air_date,
            :title_ja, :title,
            :released_year, :released_country,
            :movie_director,
            :leading_actor, :supporting_actor

        def initialize()
            yield(self) if block_given?
        end

        def show()
            puts <<"EOS"
on_air_date: #{@on_air_date}, \
title_ja: #{@title_ja}, \
title: #{@title}, \
released_year: #{@released_year}, \
released_country: #{@released_country}, \
movie_director: #{@movie_director}, \
leading_actor: #{@leading_actor}, \
supporting_actor: #{@supporting_actor}
EOS
        end
    end
end
