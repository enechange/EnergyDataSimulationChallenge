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
      ActiveRecord::Base.transaction do
        @user = User.find(id)
        @user.assign_attributes(user.to_h)
        @user.save!
      end
      { user: @user }
    end
  end
end
