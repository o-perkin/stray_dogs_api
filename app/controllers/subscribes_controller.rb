class SubscribesController < ApplicationController
  include SubscribesHelper
  before_action :set_subscribe, only: [:index, :edit, :update, :destroy]
  before_action :age_validation, only: [:create, :update]
  before_action :get_parameters_of_dogs, only: [:create, :update]
  before_action :identify_needed_dogs, only: [:create, :update]
  access [:user, :site_admin] => :all

  # GET /subscribes
  def index
  end

  # GET /subscribes/new
  def new
    unless current_user.subscribe
      @subscribe = Subscribe.new
      @subscribe.subscriptions.build
    else
      redirect_to subscribes_path, notice: 'You have alerady subscribed'
    end
  end

  # GET /subscribes/1/edit
  def edit
  end

  # POST /subscribes
  def create
    @subscribe = Subscribe.new(subscribe_params)
    @subscribe.user_id = current_user.id
    if @age == false 
      redirect_to new_subscribe_path, notice: "'Age from' can not be larger then 'Age to'. Please, try again"
    elsif @subscribe.save
      send_letters_after_subscribing(current_user, @parameters_of_dogs, @needed_dogs)
      redirect_to subscribes_path, notice: 'Subscribe was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /subscribes/1
  def update
    if @age == false 
      redirect_to edit_subscribe_path, notice: "'Age from' can not be larger then 'Age to'. Please, try again"
    elsif @subscribe.update(subscribe_params)
      send_letters_after_subscribing(current_user, @parameters_of_dogs, @needed_dogs)    
      redirect_to subscribes_path, notice: 'Subscribe was successfully updated.'
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

    def age_validation
      params[:subscribe][:subscriptions_attributes].each do |k, v| 
        if v[:age_from].to_i > v[:age_to].to_i
          @age = false
        else
          @age = true
        end
      end
    end

    def get_parameters_of_dogs
      breed = Hash.new
      city = Hash.new
      age = Hash.new
      params[:subscribe][:subscriptions_attributes].each do |k, v|
        if v[:_destroy] == 'false'         
          breed[k] = v[:breed_id] 
          city[k] = v[:city_id] 
          age[k] = ((v[:age_from].to_i)..(v[:age_to].to_i))
        end       
      end 
      @parameters_of_dogs = { breed: breed, city: city, age: age }
    end 

    def identify_needed_dogs
      @needed_dogs = []
      params[:subscribe][:subscriptions_attributes].each do |k, v|
        if v[:_destroy] == 'false'  
          @needed_dogs << Dog.where(breed_id: v[:breed_id], city_id: v[:city_id], age_id: ((v[:age_from].to_i)..(v[:age_to].to_i)))
        end
      end
      @needed_dogs
    end
end
