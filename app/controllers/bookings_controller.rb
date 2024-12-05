class BookingsController < ApplicationController
before_action :set_artwork

def create
  @booking = Booking.new(booking_params)
  @booking.user = current_user
  @booking.artwork = @artwork

  if @booking.save
    redirect_to dashboards_index_path, notice: "Booking bien enregistré."
  else
    flash.now[:alert] = "Erreur, réessayez avec des dates valides"
    render 'artworks/show'

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
