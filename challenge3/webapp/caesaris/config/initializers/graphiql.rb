# See https://github.com/rmosolgo/graphiql-rails
GraphiQL::Rails.config.headers['Authorization'] = -> (context) {
  # allow iframe use
  context.headers['X-Frame-Options'] = 'ALLOWALL'
  # eg: localhost:18000/graphiql?auth=Bearer%20XXXXXXXXXXX
  # JWT Token: "bearer XXXXXXXXXXX"
  context.params['auth']
}
