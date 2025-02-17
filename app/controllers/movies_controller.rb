class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def index

    @movies = Movie.all.order({ :created_at => :desc })

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html do
        render({ :template => "movies/index" })
      end
    end
  end

  def show
    id = params.fetch(:id)
    @movie = Movie.find(id)

    render({ :template => "movies/show" })
  end

  def create
    # @movie = Movie.new
    # @movie.title = params.fetch(:movie).fetch(:title)
    # @movie.description = params.fetch(:movie).fetch(:description)
    # sub-hashes
    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.new(movie_attributes)
    if @movie.valid?
      @movie.save
      redirect_to("/movies", { :notice => "Movie created successfully." })
    else
      render template: "movies/new"
    end
  end

  def edit
    id = params.fetch(:id)
    @movie = Movie.find(id)
  end

  def update
    id = params.fetch(:id)
    @movie = Movie.find(id)
    movie_attributes = params.require(:movie).permit(:title, :description)

    # if @movie.valid?
    if @movie.update(movie_attributes)
      redirect_to("/movies/#{@movie.id}", { :notice => "Movie updated successfully." })
    else
      # redirect_to("/movies/#{@movie.id}", { :alert => "Movie failed to update successfully." })
      render "movies/edit"
    end
  end

  def destroy
    id = params.fetch(:id)
    @movie = Movie.find(id)

    movie.destroy

    redirect_to("/movies", { :notice => "Movie deleted successfully." })
  end
end
