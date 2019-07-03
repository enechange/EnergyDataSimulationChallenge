# See https://github.com/rmosolgo/graphiql-rails
GraphiQL::Rails.config.headers['Authorization'] = -> (context) {
  # this `context` is a `view_context`

  unless AppConfig.general[:allow_graphiql]
    # will cause http status 400
    raise ActionController::BadRequest
  end

  # allow iframe use
  context.headers['X-Frame-Options'] = 'ALLOWALL'
  # eg: localhost:18000/graphiql?auth=Bearer%20XXXXXXXXXXX
  # JWT Token: "bearer XXXXXXXXXXX"
  context.params['auth']
}
