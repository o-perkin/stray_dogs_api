class DogsController < ApplicationController
  include DogsHelper
  helper_method :sort_column, :sort_direction
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  before_action :find_subscription, only: [:create]
  access all: [:show, :index, :home], user: :all, site_admin: :all
 
  # GET /dogs
  # GET /dogs.json
  def index 
    @dogs = Dog.filters(filter_params).order(sort_column + " " + sort_direction).page(params[:page]).per(5).search(params[:search])
  end

  def home
  end

  def favorites
  end

  def my_list
    @dogs = Dog.filters(filter_params).order(sort_column + " " + sort_direction).page(params[:page]).per(2).current_user(current_user.id)
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
    @favorite_exists = Favorite.where(dog: @dog, user: current_user) == [] ? false : true
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params)
    @dog.user_id = current_user.id

    respond_to do |format|
      if @dog.save
        send_letters(current_user, @dog, @subscriptions)
        format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    respond_to do |format|
      if @dog.update(dog_params)
        format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dog_params
      params.require(:dog).permit(:name, :breed_id, :city_id, :age_id, :description, :user_id, :sort, :direction, :search, :age_from, :age_to)
    end

    def filter_params
      {breed: params[:breed_id], city: params[:city_id], age_from: params[:age_from], age_to: params[:age_to]}
    end

    def find_subscription
      dog_params = params[:dog]
      subscription_without_age = Subscription.where(breed_id: dog_params[:breed_id], city_id: dog_params[:city_id])
      subscription_without_age_to = subscription_without_age.where("age_from <= ?", dog_params[:age_id])
      @subscriptions = subscription_without_age_to.where("age_to >= ?", dog_params[:age_id])
    end
end
