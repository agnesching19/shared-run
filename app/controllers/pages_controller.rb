class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
    @disable_nav = true
  end

  def about
  end
end
