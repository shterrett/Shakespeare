class RolesController < ApplicationController
  respond_to :json

  def index
    @roles = Role.sort(params[:play_id], params[:key], params[:by])
    respond_with @roles
  end

  def show
    @role = Role.find(params[:id])
    respond_with @role
  end

end
