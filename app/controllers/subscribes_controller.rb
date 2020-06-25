class SubscribesController < ApplicationController
  before_action :set_subscribe, only: [:show, :edit, :update, :destroy]
  access all: [:index, :show, :new, :edit, :create, :update, :destroy], user: :all

  # GET /subscribes
  def index
    @subscribes = Subscribe.all
  end

  # GET /subscribes/1
  def show
  end

  # GET /subscribes/new
  def new
    @subscribe = Subscribe.new
    1.times { @subscribe.subscriptions.build }
  end

  # GET /subscribes/1/edit
  def edit
  end

  # POST /subscribes
  def create
    @subscribe = Subscribe.new(subscribe_params)
    @subscribe.user_id = current_user.id

    if @subscribe.save
      redirect_to @subscribe, notice: 'Subscribe was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /subscribes/1
  def update
    if @subscribe.update(subscribe_params)
      redirect_to @subscribe, notice: 'Subscribe was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /subscribes/1
  def destroy
    @subscribe.destroy
    redirect_to subscribes_url, notice: 'Subscribe was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscribe
      @subscribe = Subscribe.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subscribe_params
      params.require(:subscribe).permit(:user_id)
    end
end
