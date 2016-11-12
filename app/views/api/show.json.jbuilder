json.extract! @user, :id, :user_name
json.deals_url api_deals_url(@user, format: :json)
