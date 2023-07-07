# DB設計
## usersテーブル
| Column | Type | Option |
|-|-|-|
| id(PK) | integer | null: false |
| nickname | string | null: false |
| email | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana | string | null: false |
| date_of_birth | date | null: false |

### Association
- has_many :items
- has_many :buys
- has_many :delivery

## itemsテーブル
| Column | Type | Option |
|-|-|-|
| id(PK) | integer | null: false |
| name | string | null: false |
| description | text | null: false |
| price | integer | null: false |
| category_id | integer | null: false |
| condition_id | integer | null: false |
| shipping_charge_id | integer | null: false |
| shipping_date_id | integer | null: false |
| prefecture_id | integer | null: false |
| user(FK) | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :buy

## buysテーブル
| Column | Type | Option |
|-|-|-|
| id(PK) | integer | null :false |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |
| delivery_id | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- belongs_to :delivery

### deliveryテーブル
| Column | Type | Option |
|-|-|-|
| id(PK) | integer | null: false |
| address | string | null: false |
| buy_id | references | null: false, foreign_key: true |
| user_id | references | null: false, foreign_key: true |

### Association
- has_many :buys
- belongs_to: user
