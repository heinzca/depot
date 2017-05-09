# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Configure rails to use smtp for email.
# By setting here, this applies to dev, test and prod. To define environment-specific, put this against the files in config/environments.
Depot::Application.configure do
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               "gmail.com",
    authentication:       "plain",
    user_name:            "heinzaufner@gmail.com",
    password:             "secret",
    enable_starttls_auto: true
  }
end
