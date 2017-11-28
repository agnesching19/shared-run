class PagesController < ApplicationController
  def home
    @disable_nav = true
    @disable_footer = true
    # search_run

    def search_run
         arr = [5, 10, 15]
         arr_pace = ['3:00', '3:15', '3:30', '3:45',
      '4:00','4:15','4:30', '4:45',
      '5:00', '5:15', '5:30', '5:45',
      '6:00', '6:15', '6:30', '6:45',
      '7:00']
        if params[:search].present?
          unless params[:search][:location] == ""
            proximity = params[:search][:proximity].to_f
            distance =  arr[(params[:search][:run_distance].to_i)]
            sociability = (params[:search][:sociability].to_i)
            @search = Search.new(search_params)
            @search.user_id = current_user.id
            @search.save
            @last_search = @user.searches.order(created_at: :desc).first
            # Date filtering
            @runs = Run.near([@last_search.latitude, @last_search.longitude], proximity)
            @runs = @runs.select { |r| r.date.strftime("%Y-%m-%d") == params[:search][:run_date] }
            # if @runs.length == 0
            #   @runs = Run.near([@last_search.latitude, @last_search.longitude], proximity * 2 )
            #   @search_widened = "No runs found - we widened your search to #{proximity * 2} km"
            # elsif @runs.length == 0
            #   @runs = Run.near([@last_search.latitude, @last_search.longitude], proximity * 3 )
            #   @search_widened = "No runs found - we widended your search to #{proximity * 3} km"
            # else
            #   @search_widened = "Sorry, we didn't find any shared runs within #{proximity *3} of you even after widening your search"
            # end
          end
        else
          @runs = Run.all
      end
    end
end

  def about
  end

  def terms
  end

  def privacy
  end
end
