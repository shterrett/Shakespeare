class PlaysController < ApplicationController

  def new
    @play = Play.new
  end

  def create
    @play = Play.new(play_params)
    if @play.save
      @play.parse_play
      flash[:success] = "Play created"
      redirect_to plays_path
    else
      flash.now[:error] = "Something went wrong"
      render 'new'
    end
  end

  def show
    @play = Play.find(params[:id])
  end

  def index
    @plays = Play.all
  end

  private 
  
  def play_params
    params.require(:play).permit(:full_text)
  end

end
