require('pry')
require_relative('../models/artists.rb')
require_relative('../models/albums.rb')

Albums.delete_all
Artists.delete_all


artist1 = Artists.new(
  {
  'name' => 'The Beatles'
  }
)

artist1.save


artist2 = Artists.new(
  {
  'name' => 'The who'
  }
)

artist2.save


album1 = Albums.new(
  {
    'title' => 'The White Album',
    'genre' => 'Rock',
    'artist_id' => artist1.id
  }
)

album1.save


album2 = Albums.new(
  {
    'title' => 'The Black Album',
    'genre' => 'Country',
    'artist_id' => artist2.id
  }
)

album2.save

album3 = Albums.new(
  {
    'title' => 'The Blacker Album',
    'genre' => 'Countryer',
    'artist_id' => artist2.id
  }
)

album3.save
