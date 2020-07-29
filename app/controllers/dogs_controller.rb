class DogsController < ApplicationController
  include DogsHelper
  include SendEmails
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  before_action :set_new_dog, only: [:create]
  access all: [:show, :index, :home], user: :all, site_admin: :all

  # GET /
  def home
  end
 
  # GET /dogs
  def index 
    @dogs = set_list_of_dogs.per(5).search(params[:search])
  end

  # GET /my_list
  def my_list
    @dogs = set_list_of_dogs.per(2).current_user(current_user.id)
  end

  # GET /my_favorites
  def favorites
  end  

  # GET /dogs/1
  def show   
    @favorite_exists = Favorite.favorite_exists?(@dog, current_user) 
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit
  end

  # POST /dogs
  def create  
    respond_to do |format|
      if @dog.save
        send_emails(current_user, set_subscriptions)
        format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /dogs/1
  def update
    respond_to do |format|
      if @dog.update(dog_params)
        format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /dogs/1
  def destroy
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
    end
  end

  private
 
    def set_dog
      @dog = Dog.find(params[:id])
    end

    def set_new_dog
      @dog = Dog.new(dog_params)
      @dog.user_id = current_user.id
    end

    def set_subscriptions      
      Subscription.find_by_dog_params(params[:dog])
    end

    def set_list_of_dogs
      Dog.filters(set_filter_params).order(sort_column + " " + sort_direction).page(params[:page])
    end

    def dog_params
      params.require(:dog).permit(:name, :breed_id, :city_id, :age_id, :description, :user_id)
    end

    def set_filter_params
      {breed: params[:breed_id], city: params[:city_id], age_from: params[:age_from], age_to: params[:age_to]}.transform_values {|v| v == "" ? v = nil : v}   
    end
end
