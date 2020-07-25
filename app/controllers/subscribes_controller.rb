class SubscribesController < ApplicationController
  include SubscribesHelper
  include NeededDogs
  include GetParamsOfSubscribedDogs
  include CheckingAge
  before_action :set_subscribe, only: [:index, :edit, :update, :destroy]
  access [:user, :site_admin] => :all

  # GET /subscribes
  def index
  end

  # GET /subscribes/new
  def new
    if current_user.subscribe
      redirect_to subscribes_path, notice: 'You have alerady subscribed'      
    else
      @subscribe = Subscribe.new
      @subscribe.subscriptions.build
    end
  end

  # GET /subscribes/1/edit
  def edit
  end

  # POST /subscribes
  def create

    @subscribe = Subscribe.new(subscribe_params)
    @subscribe.user_id = current_user.id

    if @subscribe.save && @age
      send_email_after_subscribing(current_user, @params_of_subscribed_dogs, @needed_dogs)
      redirect_to subscribes_path, notice: 'Subscribe was successfully created.'
    elsif @age == false 
      redirect_to new_subscribe_path, notice: "'Age from' can not be larger then 'Age to'. Please, try again"
    else
      render :new
    end
  end

  # PATCH/PUT /subscribes/1
  def update

    if @subscribe.update(subscribe_params) && @age
      send_email_after_subscribing(current_user, @params_of_subscribed_dogs, @needed_dogs)    
      redirect_to subscribes_path, notice: 'Subscribe was successfully updated.'
    elsif @age == false 
      redirect_to edit_subscribe_path, notice: "'Age from' can not be larger then 'Age to'. Please, try again"
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
      @subscribe = current_user.subscribe if current_user
    end

    # Only allow a trusted parameter "white list" through.
    def subscribe_params
      params.require(:subscribe).permit(:user_id, subscriptions_attributes: [:id, :breed_id, :city_id, :age_from, :age_to, :_destroy])
    end     
end
