# See https://github.com/rmosolgo/graphiql-rails
GraphiQL::Rails.config.headers['Authorization'] = -> (context) {
  # this `context` is a `view_context`

  # allow iframe use
  context.headers['X-Frame-Options'] = 'ALLOWALL'
  # eg: localhost:18000/graphiql?auth=Bearer%20XXXXXXXXXXX
  # JWT Token: "bearer XXXXXXXXXXX"
  context.params['auth']
}

class GraphiQLAuthenticate
  def matches?(request)
    return true if Rails.env.development?

    auth_code = request.params['auth']
    if !AppConfig.general[:allow_graphiql] || auth_code.blank?
      # will cause http status 400
      raise ActionController::BadRequest
    end
    _, token = URI.decode(auth_code).split(' ')
    jwt_info, _ = JWT.decode(token, Devise::JWT.config[:secret])
    # expired_at = Time.at(jwt_info['exp']) # `JWT.decode` will do tihs
    # raise JWT::ExpiredSignature if expired_at < Time.now

    # Active This for admin check, etc.
    # user = User.find_by(jwt_info.symbolize_keys.slice(:jti, :id))
    # raise ActiveRecord::RecordNotFound if user.blank? || !user.admin?
    true
  end
end
