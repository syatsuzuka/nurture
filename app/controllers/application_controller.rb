class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization
  include Pagy::Backend # For post pagination
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ensure_domain
  before_action :set_locale
  after_action :verify_authorized, except: %i[index all upload import], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: %i[index all export], unless: :skip_pundit?
  around_action :set_time_zone, if: :user_time_zone_present?
  include ApplicationHelper

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[first_name last_name email nickname role photo locale time_zone]
    )

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[
        first_name
        last_name
        email
        nickname
        manager_id
        message
        specialty
        interest
        role
        photo
        locale
        time_zone
        visible
      ]
    )
  end

  def default_url_options
    {
      host: ENV.fetch("SERVER_HOSTNAME"),
      locale: I18n.locale
    }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def ensure_domain
    if ENV.fetch("ENSURE_DOMAIN") { "" } == "1"
      return unless /\.herokuapp.com/ =~ request.host

      redirect_to "#{ENV.fetch('SERVER_HOSTNAME')}/#{request.path}", status: :moved_permanently
    end
  end

  def set_locale
    if current_user && !current_user.locale.nil?
      locale = current_user.locale.to_sym
    else
      locale = params[:locale].to_s.strip.to_sym
    end
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def set_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  def user_time_zone_present?
    current_user.try(:time_zone).present?
  end
end
