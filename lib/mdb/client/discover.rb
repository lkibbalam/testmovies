# frozen_string_literal: true

module Mdb
  class Client
    module Discover
      def discover_movie(options = {})
        response = self.class.get("/discover/movie", { query: options })
        response.parsed_response
      end
    end
  end
end
