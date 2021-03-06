# frozen_string_literal: true

class FeaturedEventPresenter
  class ParseError < StandardError; end

  def initialize(event)
    @event = event
    raise(ParseError, 'Event not provided.') unless @event

    validate
  end

  def name
    @event['Event Named']
  end

  def date
    Date.strptime(@event['Date'], '%Y-%m-%d')
  rescue StandardError
    nil
  end

  def city
    @event['Event City']
  end

  def country
    @event['Event Country']
  end

  def location
    location = ''

    location += "#{city}, " if city.present?

    location += country

    location
  end

  def url
    @event['Link']
  end

  def current?
    date > Date.yesterday
  end

  protected

  def validate
    %i[name url country date].each do |method|
      raise(ParseError, 'Invalid event.') if send(method).nil?
    end
  end
end
