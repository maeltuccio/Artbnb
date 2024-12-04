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
Booking.destroy_all
Artwork.destroy_all
User.destroy_all

# URL de l'API de l'Art Institute of Chicago
url = 'https://api.artic.edu/api/v1/artworks'
response = URI.open(url).read

# Parser les données JSON pour obtenir les œuvres d'art
artworks_data = JSON.parse(response)['data']

# Vérifie qu'il y a au moins un utilisateur dans la base
if User.count.zero?
  User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  puts "Utilisateur par défaut créé avec l'email : admin@example.com"
end
default_user = User.first

# Pour chaque œuvre récupérée, créer un enregistrement dans la base de données
artworks_data.each do |artwork_data|
  p artwork_data['id']
  next unless artwork_data['title'] && artwork_data['image_id'] && artwork_data['id'] != 271807

  # Créer l'œuvre
  artwork = Artwork.create!(
    title: artwork_data['title'],
    description: artwork_data['thumbnail'] && artwork_data['thumbnail']['alt_text'] ? artwork_data['thumbnail']['alt_text'] : 'Aucune description disponible',
    price: rand(100..10_000),
    user: default_user
  )

  # Attacher l'image via Active Storage
  image_url = "https://www.artic.edu/iiif/2/#{artwork_data['image_id']}/full/843,/0/default.jpg"
  image_file = URI.open(image_url)
  artwork.image.attach(io: image_file, filename: "#{artwork_data['image_id']}.jpg", content_type: 'image/jpeg')

  puts "Créé : #{artwork.title}"
end

puts "Les #{Artwork.count} œuvres d'art ont été ajoutées avec succès !"
