class ScoresController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def new
    @score = current_user.scores.build if signed_in?
  end

  def create
    @score = current_user.scores.build(score_params)
    if @score.save
      flash[:success] = "Score created!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @score = Score.find(params[:id])
  end

  def edit
  end

  def update
    if @score.update_attributes(score_params)
      flash[:success] = "Score updated"
      redirect_to @score
    else
      render 'edit'
    end
  end

  def destroy
    @score.destroy
    redirect_to root_url
  end

  private

    def score_params
      params.require(:score).permit(:start_date, :start_time, :team_top, :team_bottom, :t1, :b1, :t2, :b2, :t3, :b3, :t4, :b4, :t5, :b5, :t6, :b6, :t7, :b7, :t8, :b8, :t9, :b9, :end)
    end

    def correct_user
      @score = current_user.scores.find_by(id: params[:id])
      redirect_to root_url if @score.nil?
    end

end