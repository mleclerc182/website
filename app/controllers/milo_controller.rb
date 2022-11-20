class MiloController < ApplicationController
  def index
    @milopic= Milo.getpic
  end
end
