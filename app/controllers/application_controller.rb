class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: -> { render_error(t('errors.not_found')) }
  rescue_from ActionController::ParameterMissing, with: :handle_missing_params

  private

  def render_error(error_message)
    redirect_to root_path, alert: error_message
  end

  def handle_missing_params
    redirect_to new_order_path, alert: t('errors.no_items_selected')
  end
end
