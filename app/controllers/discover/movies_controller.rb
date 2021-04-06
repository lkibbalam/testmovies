# frozen_string_literal: true

module Discover
  class MoviesController < ApplicationController
    def index
      @result = Mdb::Client.new.discover_movie(page: discover_movies_params["page"])
    end

    private

    def discover_movies_params
      params.permit(:page)
    end
  end
end
