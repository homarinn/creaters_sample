class Genre < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
      {id: 1, name: '恋愛（現実世界）'}, {id: 2, name: '恋愛(異世界)'},
      {id: 3, name: 'ファンタジー'}, {id: 4, name: 'コメディー'},
      {id: 5, name: 'ラブコメ'}, {id: 6, name: '日常'},
      {id: 7, name: '青春'}, {id: 8, name: 'ヒューマンドラマ'},
      {id: 9, name: 'ミステリー'}, {id: 10, name: 'VRゲーム'},
      {id: 11, name: 'SF'}, {id: 12, name: 'アクション'},
      {id: 13, name: '純文学'}, {id: 14, name: '戦記'},
      {id: 15, name: 'ホラー'}, {id: 16, name: '童話'},
      {id: 17, name: '詩'}, {id: 18, name: 'TRPGリプレイ'},
      {id: 19, name: 'エッセイ'}, {id: 20, name: 'その他'},
  ]

  has_many :series
  has_many :novel_series
  has_many :illustration_series
  has_many :comic_series
  has_many :novels
  has_many :illustrations
  has_many :comics
end
