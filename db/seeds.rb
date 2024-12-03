# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'
require 'json'

# URL de l'API de l'Art Institute of Chicago
url = 'https://api.artic.edu/api/v1/artworks'
raw_data = URI.open(url).read  # Récupère les données de l'API

# Parser les données JSON pour obtenir les œuvres d'art
artworks_data = JSON.parse(raw_data)['data']

# Pour chaque œuvre récupérée, créer un enregistrement dans la base de données
artworks_data.each do |artwork|
  # Si la donnée est valide, on crée une œuvre
  # On assigne un prix par défaut (par exemple, 0) si aucun prix n'est trouvé dans les données
  Artwork.create(
    title: artwork['title'],
    description: artwork['description'] || 'Aucune description disponible',  # Si pas de description, on met un texte par défaut
    price: 0,  # L'API ne fournit pas de prix, donc on assigne une valeur par défaut
    user_id: User.first&.id,  # Associe l'œuvre au premier utilisateur, ou tu peux choisir un utilisateur spécifique
  )
end

puts "Artworks seeded successfully!"
