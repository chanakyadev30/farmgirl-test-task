class ApplicationController < ActionController::Base
  rescue_from ActionController::ParameterMissing, with: :handle_missing_params

  private

  def handle_missing_params
    redirect_to new_order_path, alert: t('errors.no_items_selected')
  end
end
