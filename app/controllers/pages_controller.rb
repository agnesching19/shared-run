class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @disable_nav = true
    @disable_footer = true
end

  def about
  end

  def terms
  end

  def privacy
  end
end
