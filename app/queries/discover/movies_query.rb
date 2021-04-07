# frozen_string_literal: true

module Discover
  class MoviesQuery
    Result = Struct.new(:data, :meta, :errors)

    def initialize(options = {})
      @client = Mdb::Client.new
      @options = options.symbolize_keys
    end

    def call
      Result.new(result_data, result_meta, result_errors)
    end

    def where(options)
      @options.merge!(options.symbolize_keys)
      self
    end

    private

    attr_reader :client, :options

    def query
      {
        page: page,
        certification: certification,
        certification_country: certification_country,
        "primary_release_date.gte": primary_release_date_gte,
        include_adult: include_adult
      }
    end

    def primary_release_date_gte
      options[:primary_release_date_lte] || 3.years.ago.to_date.strftime("%Y-%d-%m")
    end

    def primary_release_date_lte
      options[:primary_release_date_lte]
    end

    def certification
      options[:certification] || "G"
    end

    def certification_country
      options[:certification_country] || "US"
    end

    def include_adult
      options[:include_adult] || false
    end

    def page
      options[:page] || 1
    end

    def response
      @response ||= client.discover_movie(query)
    end

    def result_errors
      Array.wrap(response["errors"] || response["status_message"])
    end

    def request_successful?
      request_errors.empty?
    end

    def result_data
      response["results"]
    end

    def result_meta
      { page: response["page"], total_pages: response["total_pages"] }
    end

    def errors
      return [] if request_successful?

      Array.wrap(response["errors"] || response["status_message"])
    end
  end
end
