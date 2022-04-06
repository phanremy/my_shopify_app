class ApplicationController < ActionController::Base
  before_action :content_security_headers

  def content_security_headers
    response.headers['Content-Security-Policy'] += current_domain if request.get?
  end

  def current_domain
    current_domain ||= begin
      (params[:shop] && ShopifyApp::Utils.sanitize_shop_domain(params[:shop])) ||
        request.env['jwt.shopify_domain'] ||
        session[:shopify_domain]
    end

    " https://#{current_domain}"
  end
end
