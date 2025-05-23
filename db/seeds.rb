# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Clear existing data
# Movie.destroy_all

# Create 20 fake movies
# 20.times do
#   Movie.create(
#     title: Faker::Movie.title,
#     overview: Faker::Movie.quote,
#     poster_url: Faker::LoremFlickr.image(size: "300x450", search_terms: ['movie']),
#     rating: Faker::Number.between(from: 1.0, to: 10.0).round(1)
#   )
# end

# puts "Created #{Movie.count} movies."

require 'open-uri'
require 'json'

# Clear existing data
Movie.destroy_all

# URL de l'API TMDB pour les films les mieux notés
url = 'https://tmdb.lewagon.com/movie/top_rated'

# Récupérer les données JSON de l'API
response = URI.open(url).read
movies_data = JSON.parse(response)

# Créer des films à partir des données de l'API
movies_data['results'].each do |movie_data|
  Movie.create(
    title: movie_data['title'],
    overview: movie_data['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie_data['poster_path']}",
    rating: movie_data['vote_average']
  )
end

puts "Created #{Movie.count} movies."
