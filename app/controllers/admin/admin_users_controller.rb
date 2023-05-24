class Admin::AdminUsersController < ApplicationController
  before_action :authenticate_user!, :is_admin?

  def index
    @users = User.all
  end


private
end