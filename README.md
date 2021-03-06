# README
* これはポートフォリオです
* Ruby version 2.5.1
* Rails version 6.0.2.1
* MySQL 5.7
* active strageの試用

## 概要
クリエイターとクリエイターの出会いを作るサイトの原型。
大部分は小説やイラスト、漫画の投稿機能でできており、サイトのターゲットは漫画家志望の方々です。
ストーリーは考えられるが絵が描けない、絵は描けないがストーリーは考えられないという人たちをマッチングさせることを目的として作っています。
見た目はかなり仮の実装なので、手抜きの部分も多々あります。一度自力だけでやるため、Bootstrapは使わないことにしました。

## その他
### 未実装部分
現時点で未実装の機能がいくつかあります。実際に動かしていただければ分かると思います。
1. メッセージ機能
2. ジャンルの一覧ページが小説のみ表示され、漫画は未表示
3. トップページではサイドバーを用意していますが中身はまだないです。
### 命名の失敗
Seriesという名前のモデルがありますが、Serialにすべきでした。
その他にも納得のいっていない命名が複数あります。
### その他設計面やディレクトリ構造の失敗
失敗は次回に活かそうと思います。

## database設計
### User
deviseで作成
以下、deviseの自動生成には含まれない追加カラム
|カラム名|型|オプションや補足|
|------|----|-------|
|nickname|string|null: false|
|profile|text||

#### Association
- has_many :series
- has_many :novel_series
- has_many :illustration_series
- has_many :comic_series
- has_many :novels
- has_many :illustrations
- has_many :comics
- has_many :message_room_members
- has_many :message_rooms, through: :message_room_members
- has_many :messages
- has_one_attached :icon

### Series
|カラム名|型|オプションや補足|
|------|----|-------|
|title|string|null: false, index: true|
|outline|text|null: false|
|user|references||
|type|string|NovelSeries, IllustrationSeries, ComicSeries|
|genre_id|integer||
|status|integer|public_posted, private_posted|
|works_count|integer||
|posted_at|datetime||

#### Association
- belongs_to_active_hash :genre
- belongs_to :user
- has_one_attached :thumbnail

### NovelSeries < Series
#### Association
- has_many :novels, dependent: :destroy

### IllustrationSeries < Series
#### Association
- has_many :illustrations, dependent: :destroy

### ComicSeries < Series
#### Association
- has_many :comics, dependent: :destroy

### Novel
|カラム名|型|オプションや補足|
|------|----|-------|
|title|string|null: false|
|outline|text||
|content|text||
|preface|text||
|postscript|text||
|user|references||
|novel_series_id|integer||
|genre_id|integer||
|status|integer|draft, public_posted, private_posted|
|posted_at|datetime||

#### Association
- belongs_to :user
- belongs_to :novel_series, optional: true
- belongs_to_active_hash :genre

### Illustration
|カラム名|型|オプションや補足|
|------|----|-------|
|title|string|null: false|
|author_comment|text||
|user|references||
|illustration_series_id|integer||
|status|integer|draft, public_posted, private_posted|
|posted_at|datetime||

#### Association
- belongs_to :user
- belongs_to :illustration_series, optional: true
- has_one_attached :image

### Comicモデル
|カラム名|型|オプションや補足|
|------|----|-------|
|title|string|null: false|
|outline|text||
|author_comment|text||
|user|references||
|comic_series_id|integer||
|genre_id|integer||
|status|integer|draft, public_posted, private_posted|
|posted_at|datetime||

#### Association
- belongs_to :user
- belongs_to :comic_series, optional: true
- belongs_to_active_hash :genre
- has_many_attached :images


### Genre
active_hashで作成

self.data = [
  { id: 1, name: string, path_name: string },
  { id: 2, name: string, path_name: string },
  { id: 3, name: string, path_name: string },
            ・
            ・
            ・
]

#### Association
- has_many :series
- has_many :novel_series
- has_many :comic_series
- has_many :novels
- has_many :comics

### Message
|カラム名|型|オプションや補足|
|------|----|-------|
|content|text|null: false|
|user|references||
|message_room|references||

#### Association
- belongs_to :user
- belongs_to :message_room

### MessageRoom
|カラム名|型|オプションや補足|
|------|----|-------|
|name|string|null: false|
|type|string|DirectMessageRoom, GroupMessageRoom|

#### Association
- has_many :message_room_members
- has_many :users, through: :message_room_members
- has_many :messages

### DirectMessageRoom < MessageRoom
### GroupMessageRoom < MessageRoom

### MessageRoomMember
|カラム名|型|オプションや補足|
|------|----|-------|
|user|references||
|message_room|references||

#### Association
- belongs_to :user
- belongs_to :message_room