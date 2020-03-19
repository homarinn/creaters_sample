class Genre < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
    {id: 1, name: '恋愛（現実世界）', path_name: 'love_in_real'}, {id: 2, name: '恋愛(異世界)', path_name: 'love_in_another'},
    {id: 3, name: 'ファンタジー', path_name: 'fantasy'}, {id: 4, name: 'コメディー', path_name: 'comedy'},
    {id: 5, name: 'ラブコメ', path_name: 'love_comedy'}, {id: 6, name: '日常', path_name: 'life'},
    {id: 7, name: '青春', path_name: 'springtime_of_life'}, {id: 8, name: 'ヒューマンドラマ', path_name: 'drama'},
    {id: 9, name: 'ミステリー', path_name: 'mystery'}, {id: 10, name: 'VRゲーム', path_name: 'vr_game'},
    {id: 11, name: 'SF', path_name: 'space_fantasy'}, {id: 12, name: 'アクション', path_name: 'action'},
    {id: 13, name: '純文学', path_name: 'classic_literature'}, {id: 14, name: '戦記', path_name: 'saga'},
    {id: 15, name: 'ホラー', path_name: 'horror'}, {id: 16, name: '童話', path_name: 'fairy_tale'},
    {id: 17, name: '詩', path_name: 'poem'}, {id: 18, name: 'TRPGリプレイ', path_name: 'trpg'},
    {id: 19, name: 'エッセイ', path_name: 'essay'}, {id: 20, name: 'その他', path_name: 'others'},
  ]

  has_many :series
  has_many :novel_series
  has_many :comic_series
  has_many :novels
  has_many :comics
end
