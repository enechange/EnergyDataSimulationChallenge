module Mutations
  class UpdateUser < BaseMutation
    description "Update User Info"
    # return fields
    field :user, Types::UserType, null: false

    # define arguments
    argument :id, ID, required: true,
      description: "Find User by ID for Update"
    argument :user, Types::UpdateUserType, required: true,
      description: "User Info"

    # define resolve method
    def resolve(id:, user:)
      Util.auth_user_graphql(context[:current_user])
      user_params = user.to_h
      if user_params[:password].present?
        user_params[:password_confirmation] = user_params[:password]
      end

      ActiveRecord::Base.transaction do
        @user = User.find(id)
        alt_login_flg = user_params[:email].present? || user_params[:password].present?
        default_user_flg = @user.email == EasySettings.default_user.email
        demo_user_flg = @user.email == EasySettings.demo_user.email
        @user.assign_attributes(user_params)
        if default_user_flg && (alt_login_flg || !@user.admin?)
          msg = "GraphQL: Can not alt default user's email, password or roles"
          raise GraphQL::ExecutionError, msg
        end
        if demo_user_flg && alt_login_flg
          msg = "GraphQL: Can not alt demo user's email or password"
          raise GraphQL::ExecutionError, msg
        end
        @user.save!
      end
      { user: @user }
    end
  end
end
