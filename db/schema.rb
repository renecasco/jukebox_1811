# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190415202037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "awards", force: :cascade do |t|
    t.string "name"
  end

  create_table "order_songs", force: :cascade do |t|
    t.bigint "song_id"
    t.bigint "order_id"
    t.integer "quantity"
    t.index ["order_id"], name: "index_order_songs_on_order_id"
    t.index ["song_id"], name: "index_order_songs_on_song_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "playlist_songs", force: :cascade do |t|
    t.bigint "song_id"
    t.bigint "playlist_id"
    t.index ["playlist_id"], name: "index_playlist_songs_on_playlist_id"
    t.index ["song_id"], name: "index_playlist_songs_on_song_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "song_awards", force: :cascade do |t|
    t.bigint "song_id"
    t.bigint "award_id"
    t.index ["award_id"], name: "index_song_awards_on_award_id"
    t.index ["song_id"], name: "index_song_awards_on_song_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.integer "length"
    t.integer "play_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "artist_id"
    t.index ["artist_id"], name: "index_songs_on_artist_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "role", default: 0
  end

  add_foreign_key "order_songs", "orders"
  add_foreign_key "order_songs", "songs"
  add_foreign_key "orders", "users"
  add_foreign_key "playlist_songs", "playlists"
  add_foreign_key "playlist_songs", "songs"
  add_foreign_key "song_awards", "awards"
  add_foreign_key "song_awards", "songs"
  add_foreign_key "songs", "artists"
end
