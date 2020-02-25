# README
* Ruby version 2.5.1
* Rails version 6.0.2.1
* active strageやaction textの試用

## 概要
クリエイターとクリエイターの出会いを作るサイトの原型。
大部分は小説やイラスト、漫画の投稿機能でできており、サイトのターゲットは漫画家志望の方々です。
ストーリーは考えられるが絵が描けない、絵は描けないがストーリーは考えられないという人たちをマッチングさせることを目的として作っています。
後々、プロジェクトチーム作成機能も拡張して追加する予定。

## database設計
### User
deviseで作成
以下、deviseの自動生成には含まれない追加カラム
|------|----|-------|
|nickname|string|null: false|
|profile|text||

#### Association
- has_many :series
- has_many :novels
- has_many :illustrations
- has_many :comics
- has_many :message_room_members
- has_many :message_rooms, through: :message_room_members
- has_many :messages
- has_one_attached :icon

### Series
|------|----|-------|
|title|string|null: false, index: true|
|outline|text|null: false|
|user|references||
|type|string|NovelSeries, IllustrationSeries, ComicSeries|

#### Association
- belongs_to :genre
- belongs_to :user

### NovelSeries < Series
#### Association
- has_many :novels, dependent: :destroy

### IllustrationSeries < Series
#### Association
- has_many :illustrations, dependent: :destroy
- has_one_attached :thumbnail

### ComicSeries < Series
#### Association
- has_many :comics, dependent: :destroy
- has_one_attached :thumbnail

### Novel
|------|----|-------|
|title|string|null: false|
|preface|text||
|postscript|text||
|user|references||
|novel_series_id|integer||

#### Association
- belongs_to :user
- belongs_to :novel_series, optional: true
- belongs_to :genre, optional: true
- has_rich_text :content

### Illustration
|------|----|-------|
|title|string|null: false|
|author_comment|text||
|user|references||
|illustration_series_id|integer||

#### Association
- belongs_to :user
- belongs_to :illustration_series, optional: true
- belongs_to :genre, optional: true
- has_one_attached :image

### Comicモデル
|------|----|-------|
|title|string|null: false|
|author_comment|text||
|user|references||
|comic_series_id|integer||

#### Association
- belongs_to :user
- belongs_to :comic_series, optional: true
- belongs_to :genre, optional: true
- has_one_attached :thumbnail
- has_many_attached :images

### Genre
|------|----|-------|
|name|string|null: false|

#### Association
- has_many :series
- has_many :novels
- has_many :illustrations
- has_many :comics

### Message
|------|----|-------|
|content|text|null: false|
|user|references||
|message_room|references||

#### Association
- belongs_to :user
- belongs_to :message_room

### MessageRoom
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
|------|----|-------|
|user|references||
|message_room|references||

#### Association
- belongs_to :user
- belongs_to :message_room