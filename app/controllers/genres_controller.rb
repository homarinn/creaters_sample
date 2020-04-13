class GenresController < ApplicationController
  def index
    genre_id = Genre.find_by(path_name: request.path).id
    @novel_series = Search::NovelSeries.run(genre_id: genre_id)
    @comic_series = Search::ComicSeries.run(genre_id: genre_id)
  end
end