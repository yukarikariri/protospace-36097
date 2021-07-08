class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_prototype, only: [:show, :edit, :update]
  before_action :move_to_edit, only: [:edit]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_paramas)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    # before_actionに纏めたけど備忘として残す
    # @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    # before_actionに纏めたけど備忘として残す
    # @prototype = Prototype.find(params[:id])
  end

  def update
    # before_actionに纏めたけど備忘として残す
    # @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_paramas)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_paramas
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_edit 
    unless current_user.id == @prototype.user_id
      redirect_to root_path
    end
  end
end
