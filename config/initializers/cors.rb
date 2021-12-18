Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    cors_hosts = '*'
    origins [cors_hosts] unless cors_hosts.blank?

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end