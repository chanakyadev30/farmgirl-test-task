module Errors
  class InvalidDateError < StandardError
    def initialize(msg = I18n.t('errors.invalid_date'))
      super
    end
  end
end
