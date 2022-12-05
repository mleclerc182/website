class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def create
    #@user = User.find(params[:user_id])
    # @profile = @user.build_profile(profile_params)
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    if Profile.exists? user_id: current_user.id
      update
    else
      if @profile.save
        redirect_to root_path
      else
        render :new
      end
    end
  end

  def update
    @profile = Profile.find_by(user_id: current_user.id)
    if @profile.update(profile_params)
      redirect_to root_path
    else
      render :new
    end
  end
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
  end
end

