module Mutations
  class NewUser < BaseMutation
    description "Add New User"
    # return fields
    field :user, Types::UserType, null: false

    # define arguments
    argument :user, Types::NewUserType, required: true,
      description: "User Info"

    # define resolve method
    def resolve(user:)
      Util.auth_user_graphql(context[:current_user])
      ActiveRecord::Base.transaction do
        @user = User.create!(user.to_h)
      end
      { user: @user }
    end
  end
end
