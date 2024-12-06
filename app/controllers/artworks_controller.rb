class ArtworksController < ApplicationController
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @banner_image = "https://res.cloudinary.com/dcztp85ae/image/upload/v1733417582/development/j99p161gzy7sbi8ycqnq4ix1aj5j.jpg"
    if params[:query].present?
      @artworks = Artwork.where("title ILIKE :query OR description ILIKE :query", query: "%#{params[:query]}%")
    else
      @artworks = Artwork.all
    end

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
    raise
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
