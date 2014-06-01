class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @scores = current_user.scores.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
