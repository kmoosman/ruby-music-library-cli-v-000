class MusicLibraryController

  extend Concerns::Findable
  attr_accessor :music

  def initialize(path  = './db/mp3s')
    imported_music = MusicImporter.new(path)
    @music = imported_music.import

  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets
    until input.chomp == 'exit'
      input = gets
    end
  end

  def list_songs
    song_index = 0
    songs_by_name = Song.all.collect.sort_by do |song|
      song.name
     end

     songs_by_name.collect do |song|
       song_index += 1
      puts "#{song_index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artist_index = 0
    artist_by_name = Artist.all.collect.sort_by do |artist|
      artist.name
     end

     artist_by_name.collect do |artist|
       artist_index += 1
      puts "#{artist_index}. #{artist.name}"
    end
  end

  def list_genres
    genre_index = 0
    genres = Genre.all.collect.sort_by do |genre|
      genre.name
     end

     genres.collect do |genre|
       genre_index += 1
      puts "#{genre_index}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input_artist = gets.chomp
    songs_by_artist = []
    index = 0

    Song.all.collect do |song|
      if song.artist.name == input_artist
        songs_by_artist << song
      end
    end

    sorted_songs = songs_by_artist.sort_by do |song|
      song.name
    end

    sorted_songs.each do |song|
      index += 1
     puts "#{index}. #{song.name} - #{song.genre.name}"
   end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input_genre = gets.chomp
    songs_by_genre = []
    index = 0

    Song.all.collect do |song|
      if song.genre.name == input_genre
        songs_by_genre << song
      end
    end

    sorted_songs = songs_by_genre.sort_by do |song|
      song.name
    end

    sorted_songs.each do |song|
      index += 1
     puts "#{index}. #{song.artist.name} - #{song.name}"
   end
  end

  def play_song

    songs_by_name = Song.all.collect.sort_by do |song|
      song.name
     end

    puts "Which song number would you like to play?"
    song_selected = gets.chomp.to_i
    input = song_selected-1
    song_name = songs_by_name[input]
    if song_selected > 0
      if songs_by_name[input] != nil
        puts "Playing #{songs_by_name[input].name} by #{songs_by_name[input].artist.name}" 
      end
    end



    # songs_by_name = Song.all.collect.sort_by do |song|
    #   song.name
    #  end
    # song_number = song_selected.to_i
    # if song_selected.to_i > 0
    #   if list_songs.contains[song_selected]
    #     puts "Playing " unless song_selected == nil
    #   end
    #   {songs_by_name}
    # else
    #   puts "Which song number would you like to play?"
    # end
  end


end
