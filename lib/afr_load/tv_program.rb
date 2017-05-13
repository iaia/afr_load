# encoding: utf-8

module AfrLoad
  class TvProgram
    attr_accessor :on_air_date,
      :on_air_start, :on_air_end,
      :title_ja, :title,
      :released_year, :released_country,
      :movie_director,
      :leading_actor, :supporting_actor

    def initialize()
      yield(self) if block_given?
    end

    def show()
      instance_variables.each do |var|
        k = var.to_s.tr("@","")
        v = instance_variable_get(var)
        print "#{k}: #{v}, "
      end
      puts
    end
  end
end
