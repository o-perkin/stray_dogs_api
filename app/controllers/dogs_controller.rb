class DogsController < ApplicationController
  include DogsHelper
  include SetSubscriptions
  helper_method :sort_column, :sort_direction
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  before_action :set_favorites, only: [:show]
  access all: [:show, :index, :home], user: :all, site_admin: :all

  # GET /
  def home
  end
 
  # GET /dogs
  def index 
    @dogs = set_list_of_dog.per(5).search(params[:search])
  end

  # GET /my_list
  def my_list
    @dogs = set_list_of_dog.per(2).current_user(current_user.id)
  end

  # GET /my_favorites
  def favorites
  end  

  # GET /dogs/1
  def show    
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
    @dog = Dog.new(dog_params)
    @dog.user_id = current_user.id

    respond_to do |format|
      if @dog.save
        send_email_after_adding_dog(current_user, @dog, @subscriptions)
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

    def set_favorites     
      @favorite_exists = Favorite.where(dog: @dog, user: current_user) == [] ? false : true
    end

    def set_list_of_dog
      Dog.filters(filter_params).order(sort_column + " " + sort_direction).page(params[:page])
    end

    def dog_params
      params.require(:dog).permit(:name, :breed_id, :city_id, :age_id, :description, :user_id)
    end

    def filter_params
      {breed: params[:breed_id], city: params[:city_id], age_from: params[:age_from], age_to: params[:age_to]}
    end  
end
