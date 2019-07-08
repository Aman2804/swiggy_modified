json.extract! coupon, :id, :condition, :coupon_name, :per_off, :type_of_coupon, :created_at, :updated_at
json.url coupon_url(coupon, format: :json)
