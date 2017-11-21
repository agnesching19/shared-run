class SearchesController < ApplicationController
  def search
      @search = Search.create(run_params)
  end
end
