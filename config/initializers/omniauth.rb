Rails.application.config.middleware.use OmniAuth::Builder do
  provider :canvas, Rails.application.secrets.oauth_key, Rails.application.secrets.oauth_secret, :setup => lambda{|env|
    env['omniauth.strategy'].options[:client_options].site = "https://atomicjolt.instructure.com"
  }
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :canvas, :setup => lambda{|env|
    request = Rack::Request.new(env)
    if organization = Account.find_by(id: request.params["account_id"])
      env['omniauth.strategy'].options[:client_id] = Rails.application.secrets.oauth_id
      env['omniauth.strategy'].options[:client_secret] = Rails.application.secrets.oauth_key
      env['omniauth.strategy'].options[:client_options].site = Rails.application.secrets.canvas_url
    else
      throw "Unable to find account with id: #{request.params["account_id"]}"
    end
  }
end