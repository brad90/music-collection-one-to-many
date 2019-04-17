require('pg')
require_relative('../db/sql_runner.rb')
require_relative('artists')

class Albums

  attr_reader :title, :id

  def initialize(options)

    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id']

  end

  def save()
    sql = "INSERT INTO albums
    (
      title,
      genre,
      artist_id
    ) VALUES
    (
      $1,$2,$3
    )
    RETURNING id"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "SELECT * FROM albums
    (
      title,
      genre,
      artist_id
    ) =
    (
      $1,$2,$3
    )
    WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    result = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    album_hash = result.first
    order = Albums.new(album_hash)
  end

  def self.find_by_artist(artist_id)
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [artist_id]
    result = SqlRunner.run(sql, values)
    return result.map{ |res| self.new(res)}
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    result = SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    return result.map{ |res| self.new(res)}
  end



end
