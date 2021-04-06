# frozen_string_literal: true

require_relative "client/discover"

module Mdb
  class Client
    include HTTParty
    include Mdb::Client::Discover

    base_uri "https://api.themoviedb.org/3"
    format :json

    def initialize(access_token = nil)
      access_token ||= ENV["MOVIEDBAPI_ACCESS_TOKEN"]
      self.class.default_options.merge!(headers: { "Authorization" => "Bearer #{access_token}" })
    end
  end
end
