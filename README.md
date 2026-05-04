# テーブル設計

## users テーブル

| Column              | Type   | Options                  |
| ------------------- | ------ | ------------------------ |
| nickname            | string | null: false              |
| email               | string | null: false unique: true |
| encrypted_password  | string | null: false              |
| line_user_id        | string |                          |
| sleep_time          | time   | null: false              |

### Associations
has_many :learnings, dependent: :destroy
has_many :reviews, through: :learnings
<!-- lerningテーブルを通じて、reviewsがuserデータを辿れるよ -->

## learnings テーブル 

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| content         | string     | null: false                    |
| keyword         | string     |                                |
| user            | references | null: false, foreign_key: true |

### Associations
belongs_to :user
has_many :reviews, dependent: :destroy
<!-- reviewsを3形態（0: 想起, 1: 理解, 2: 応用)に分割し管理 -->

## reviews テーブル

| Column       | Type         | Options                        |
| ------------ | ------------ | ------------------------------ |
| learning     | references   | null: false, foreign_key: true |
| review_type  | integer      | null: false                    |
| scheduled_at | datetime     | null: false                    |
| status       | integer      | null: false, default: 0        |

### Associations
belongs_to :learning
<!-- enumで可読性・保守性を上げる -->



