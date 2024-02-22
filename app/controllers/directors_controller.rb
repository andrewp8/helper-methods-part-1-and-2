class DirectorsController < ApplicationController
  def new
    @director = Director.new
  end
  def index
    @directors = Director.all.order({dob: :desc})
  end

end
