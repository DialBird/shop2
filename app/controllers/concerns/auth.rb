module Auth
  extend ActiveSupport::Concern

  included do
    before_action :set_guest_token
  end

  private

  def set_guest_token
    unless cookies.signed[:guest_token].present?
      cookies.permanent.signed[:guest_token] =
        SecureRandom.urlsafe_base64
    end
  end
end
