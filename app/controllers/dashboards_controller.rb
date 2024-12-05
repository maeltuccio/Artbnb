class DashboardsController < ApplicationController
  before_action :authenticate_user! # Assurez-vous que l'utilisateur est connecté

  def index
    # Récupérer les réservations en cours de l'utilisateur
    @artworks = Artwork.where(user: current_user)
    @current_bookings = current_user.bookings #.where('start_date <= ? AND end_date >= ?', Time.now, Time.now)
  end



end
