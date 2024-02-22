class DirectorsController < ApplicationController
  def new
    @director = Director.new
  end
  def index
    @directors = Director.all.order({dob: :desc})
  end
  def show
    id = params.fetch(:id)
    @director = Director.find(id)
  end

  def create
    director_attributes = params.require(:director).permit(:name, :dob)
    @director = Director.new(director_attributes)
    if @director.valid?
      @director.save
      redirect_to(directors_path, {notice: "Director created successfully."})
    else
      render "directors/new"
    end
  end
  def edit
    id = params.fetch(:id)
    @director = Director.find(id)
  end
  def update
    id = params.fetch(:id)
    @director = Director.find(id)
    director_attributes = params.require(:director).permit(:name,:dob)
    if @director.update(director_attributes)
      redirect_to(director_path(@director), {notice: "Director updated successfully."})
    else
      render "directors/edit"
    end
  end
  def destroy
    id = params.fetch(:id)
    director = Director.find(id)
    director.destroy
    redirect_to(directors_path, {notice: "Director deleted successfully."})
  end
end
