# frozen_string_literal: true

module Discover
  class MoviesController < ApplicationController
    before_action :authenticate_user!
    
    def index
      @result = policy_scope(DiscoverMovies.new(page: discover_movies_params[:page]),
                             policy_scope_class: ::Discover::MoviesPolicy::Scope).call
      # binding.pry
      if @result["errors"]&.any?
        flash[:alert] = @result["errors"] || @result["status_message"]
        redirect_to discover_movies_path
      end
    end

    private

    def discover_movies_params
      params.permit(:page)
    end
  end
end
