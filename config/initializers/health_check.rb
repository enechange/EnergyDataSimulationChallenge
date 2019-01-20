HealthCheck.setup do |config|
  # uri prefix (no leading slash)
  config.uri = 'health_check'

  # Text output upon success
  config.success = 'success'

  # Timeout in seconds used when checking smtp server
  config.smtp_timeout = 60.0

  # http status code used when plain text error message is output
  # Set to 200 if you want your want to distinguish between partial (text does not include success) and
  # total failure of rails application (http status of 500 etc)

  config.http_status_for_error_text = 500

  # http status code used when an error object is output (json or xml)
  # Set to 200 if you want your want to distinguish between partial (healthy property == false) and
  # total failure of rails application (http status of 500 etc)
  config.http_status_for_error_object = 500

  # You can customize which checks happen on a standard health check, eg to set an explicit list use:
  config.standard_checks = %w[database migrations]

  # You can set what tests are run with the 'full' or 'all' parameter
  config.full_checks = %w[database migrations]

  # Add one or more custom checks that return a blank string if ok, or an error message if there is an error
  # config.add_custom_check do
  #   CustomHealthCheck.perform_check # any code that returns blank on success and non blank string upon failure
  # end

  # max-age of response in seconds
  # cache-control is public when max_age > 1 and basic_auth_username is not set
  # You can force private without authentication for longer max_age by
  # setting basic_auth_username but not basic_auth_password
  config.max_age = 1

  # http status code used when the ip is not allowed for the request
  config.http_status_for_ip_whitelist_error = 403

  # Disable the error message to prevent /health_check from leaking
  # sensitive information
  # config.include_error_in_response_body = false
end
