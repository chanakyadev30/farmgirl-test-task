class DateParserService < ApplicationService
  def initialize(date)
    @date = date
  end

  def call
    parse(@date)
  end

  private

  # parse date if a valid date string
  def parse(date)
    return nil if date.blank?

    begin
      Date.strptime(date).to_datetime
    rescue StandardError
      raise Errors::InvalidDateError
    end
  end
end
