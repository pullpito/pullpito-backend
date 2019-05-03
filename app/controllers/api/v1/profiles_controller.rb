class Api::V1::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = Profile.find_by(id: params[:id])
    if @profile
      render json: @profile.to_json(methods: [:full_name]), status: 200
    else
      render json: { error: "Profile not found" }, status: 404
    end
  end
end
