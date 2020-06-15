class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  access all: [:show, :index, :home, :favorites, :destroy, :new, :create, :update, :edit, :my_list], site_admin: :all

  # GET /dogs
  # GET /dogs.json
  def index
    @dogs = Dog.page(params[:page]).per(3)
  end

  def home
  end

  def favorites
  end

  def my_list
    @dogs = Dog.where(user_id: current_user.id)
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
      params.require(:dog).permit(:name, :breed_id, :city_id, :age_id, :description, :user_id)
    end
end
