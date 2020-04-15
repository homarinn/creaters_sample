class GenresController < ApplicationController
  def index
    genre_id = Genre.find_by(path_name: request.path.gsub('/', '')).id
    @novel_series = Search::NovelSeries.run(genre_id: genre_id)
    @novels = Search::Novels.run(genre_id: genre_id)
    @comic_series = Search::ComicSeries.run(genre_id: genre_id)
    @comics = Search::Comics.run(genre_id: genre_id)
  end
end