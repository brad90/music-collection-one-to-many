require('pg')
require_relative('../db/sql_runner.rb')
require_relative('albums')

class Artists

  attr_reader :name, :id

  def initialize(options)

    @id = options['id'].to_i if options['id']
    @name = options['name']

  end

  def save()
    sql = "INSERT INTO artists
    (
      name
    ) VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "SELECT * FROM artists
    (
      name
    ) =
    (
      $1
    )
    WHERE id = $2"
    values = [@name, @id]
    result = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    artists_hash = result.first
    order = Artists.new(artist_hash)
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    result = SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    return result.map {|res| Artist.new(res)}
  end














end
