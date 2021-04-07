# frozen_string_literal: true

class DiscoverMovies
  def initialize(options = {})
    @client = Mdb::Client.new
    @options = options.symbolize_keys
  end

  def call
    client.discover_movie(page: page,
                          certification: certification,
                          certification_country: certification_country,
                          "primary_release_date.gte": primary_release_date_gte,
                          include_adult: include_adult)
  end

  def where(options)
    @options.merge!(options.symbolize_keys)
    self
  end

  private

  attr_reader :client, :options

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
end
