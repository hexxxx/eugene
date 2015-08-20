class ProteinsController < ApplicationController

  def index
    @protein = Protein.all
  end

  def new
    @protein = Protein.new
  end

  def show
  end

  def create
  end

  def update
  end
end
