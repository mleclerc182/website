class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end
  def edit
    @profile = Profile.find_by_user_id(current_user.id)
  end


  def create
    #@user = User.find(params[:user_id])
    # @profile = @user.build_profile(profile_params)
    @profile = Profile.new(profile_params)
    @profile.user = current_user
      if @profile.save
        redirect_to user_path(@profile.user_id)
      else
        render :new
      end
  end


  def update
    @profile = Profile.find_by(user_id: current_user.id)
    if @profile.update(profile_params)
      redirect_to user_path(@profile.user_id)
    else
      render :new
    end
  end
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
  end
end

