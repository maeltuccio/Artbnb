cclass BookingsController < ApplicationController
before_action :set_artwork

def create
  @booking = Booking.new(booking_params)
  @booking.user = current_user
  @booking.artwork = @artwork

  if @booking.save
    redirect_to @artwork, notice: "Booking was successfully created."
  else
    render 'artworks/show', alert: "There was an issue with your booking."
  end
end

private

def set_artwork
  @artwork = Artwork.find(params[:artwork_id])
end

def booking_params
  params.require(:booking).permit(:start_date, :end_date)
end
