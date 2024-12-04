class ArtworksController < ApplicationController
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @artworks = Artwork.all
  end

  def new
    @artwork = Artwork.new
  end

  def create
    @artwork = Artwork.new(artwork_params)
    @artwork.user = current_user
    if @artwork.save
      redirect_to @artwork, notice: 'Artwork was successfully created.'
    else
      render :new
    end
  end

  def show
    @booking = Booking.new
  end

  def edit
  end

  def update
    if @artwork.update(artwork_params)
      redirect_to @artwork, notice: 'Artwork was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @artwork.destroy
    redirect_to artworks_path, notice: 'Artwork was successfully destroyed.'
  end

  private

  def set_artwork
    @artwork = Artwork.find(params[:id])
  end

  def artwork_params
    params.require(:artwork).permit(:title, :description, :price, :image)
  end
end
