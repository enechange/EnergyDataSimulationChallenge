module Mutations
  class DeleteUser < BaseMutation
    description "Delete User"
    # return fields
    field :user, Types::UserType, null: false

    # define arguments
    argument :id, ID, required: true, description: "Delete User by ID"

    # define resolve method
    def resolve(id:)
      Util.auth_user_graphql(context[:current_user])
      ActiveRecord::Base.transaction do
        @user = User.find(id)
        default_user_flg = @user.email == EasySettings.default_user.email
        demo_user_flg = @user.email == EasySettings.demo_user.email
        if default_user_flg || demo_user_flg
          msg = "GraphQL: Can not delete demo or default user"
          raise GraphQL::ExecutionError, msg
        end
        @user.destroy!
      end
      { user: @user }
    end
  end
end
