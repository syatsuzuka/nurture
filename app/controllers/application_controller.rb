class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # include Pundit
  include Pundit::Authorization
  # For post pagination
  include Pagy::Backend
  # Pundit: white-list approach.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ensure_domain
  after_action :verify_authorized, except: %i[index all upload import], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: %i[index all], unless: :skip_pundit?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[first_name last_name email nickname role photo]
    )

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[first_name last_name email nickname message specialty interest role photo visible]
    )
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def ensure_domain
    return unless /\.herokuapp.com/ =~ request.host

    redirect_to "#{ENV['SERVER_HOSTNAME']}/#{request.path}", status: :moved_permanently
  end
end
