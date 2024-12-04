class BookingsController < ApplicationController
before_action :set_artwork

def create
  @booking = Booking.new(booking_params)
  @booking.user = current_user
  @booking.artwork = @artwork

  if @booking.save
    redirect_to "dashboards/index", notice: "Booking bien enregistré."
  else
    render 'artworks/show', alert: "Il y a un problème avec votre résa"
  end
end


private

def set_artwork
  @artwork = Artwork.find(params[:artwork_id])
end

def booking_params
  params.require(:booking).permit(:start_date, :end_date)
end
end
