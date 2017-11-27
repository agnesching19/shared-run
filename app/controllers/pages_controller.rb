class PagesController < ApplicationController
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
