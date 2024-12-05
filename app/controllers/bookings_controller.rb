class BookingsController < ApplicationController
  before_action :set_artwork

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.artwork = @artwork
    @booking.status = "Pending"

    if @booking.save
      redirect_to dashboards_index_path, notice: "Booking bien enregistré."
    else
      flash.now[:alert] = "Erreur, réessayez avec des dates valides"
      render 'artworks/show'

    end
  end

  def accept
  raise
    if @booking.update(status: 'Confirmed')  # Mettez à jour le statut à 'Confirmed'
      redirect_to dashboards_path, notice: "Réservation confirmée avec succès!"
    else
      redirect_to dashboards_path, alert: "Il y a eu un problème avec la confirmation de la réservation."
    end
  end

  def decline
  raise
    if @booking.update(status: 'Cancelled')  # Mettez à jour le statut à 'Cancelled'
      redirect_to dashboards_path, notice: "Réservation annulée avec succès."
    else
      redirect_to dashboards_path, alert: "Il y a eu un problème avec l'annulation de la réservation."
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
