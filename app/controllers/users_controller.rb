class UsersController < ApplicationController

  def show
    @user = current_user
    @lists = @user.lists
  end

end
