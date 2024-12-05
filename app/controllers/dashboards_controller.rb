class DashboardsController < ApplicationController
  before_action :authenticate_user! # Assurez-vous que l'utilisateur est connecté

  def index
    # Récupérer les réservations en cours de l'utilisateur
    @artworks = Artwork.where(user: current_user)
    @current_bookings = current_user.bookings.where('start_date <= ? AND end_date >= ?', Time.now, Time.now)
  end

  def accept
    if @booking.update(status: 'Confirmed')  # Mettez à jour le statut à 'Confirmed'
      redirect_to dashboards_path, notice: "Réservation confirmée avec succès!"
    else
      redirect_to dashboards_path, alert: "Il y a eu un problème avec la confirmation de la réservation."
    end
  end

  def decline
    if @booking.update(status: 'Cancelled')  # Mettez à jour le statut à 'Cancelled'
      redirect_to dashboards_path, notice: "Réservation annulée avec succès."
    else
      redirect_to dashboards_path, alert: "Il y a eu un problème avec l'annulation de la réservation."
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
    unless @booking.user == current_user  # Vérifiez que l'utilisateur est bien celui qui a fait la réservation
      redirect_to dashboards_path, alert: "Vous n'êtes pas autorisé à modifier cette réservation."
    end
  end

end
