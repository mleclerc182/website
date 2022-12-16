class PagesController < ApplicationController

  def about
  end

  def home
    @profiles = Profile.all
  end
end
