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

ActiveRecord::Schema.define(version: 2019_07_09_075618) do

  create_table "addresses", force: :cascade do |t|
    t.string "flat_no"
    t.string "location"
    t.string "city"
    t.string "landmark"
    t.string "address_type", default: "home"
    t.string "addressable_type"
    t.integer "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "cart_id"
    t.integer "restaurant_item_id"
    t.integer "num_of_item"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["restaurant_item_id"], name: "index_cart_items_on_restaurant_item_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "coupons", force: :cascade do |t|
    t.string "condition"
    t.string "coupon_name"
    t.integer "per_off"
    t.string "type_of_coupon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.integer "order_id"
    t.integer "vehicle_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_deliveries_on_order_id"
    t.index ["vehicle_id"], name: "index_deliveries_on_vehicle_id"
  end

  create_table "favourite_restaurants", force: :cascade do |t|
    t.integer "user_id"
    t.integer "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_favourite_restaurants_on_restaurant_id"
    t.index ["user_id"], name: "index_favourite_restaurants_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "type_of_dish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "restaurant_item_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["restaurant_item_id"], name: "index_order_items_on_restaurant_item_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "restaurant_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "final_amount"
    t.string "type_of_pay"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "restaurant_items", force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "item_id"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_restaurant_items_on_item_id"
    t.index ["restaurant_id"], name: "index_restaurant_items_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "designation"
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_restaurants_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.integer "user_id"
    t.string "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "contact"
    t.string "gender"
    t.string "city"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "current_role"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.integer "user_id"
    t.string "vehicle"
    t.string "vehicle_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

end
