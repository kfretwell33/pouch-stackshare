json.array!(@deals) do |deal|
  
  if ((deal.campaign.expiration_date - Time.now.utc)/60/60/24) < 3
    json.expiration_date_red true
  else
    json.expiration_date_red false
  end

  json.deal_id deal.id
  
  json.campaign_name deal.campaign.campaign_name
  json.description deal.campaign.description
  json.campaign_url deal.campaign.campaign_url
  

  json.expiration_date deal.campaign.expiration_date.in_time_zone(deal.time_zone).strftime("%b %d at ") + deal.campaign.expiration_date.in_time_zone(deal.time_zone).strftime("%l:%M%P %Z").strip

  json.expiration_date_short deal.campaign.expiration_date.in_time_zone(deal.time_zone).strftime("%B %d")

  
  json.user_time_zone deal.time_zone

  

  json.promocode deal.campaign.promo_code
  json.campaign_id deal.campaign_id
  json.brand_name deal.campaign.brand.brand_name
  json.brand_image deal.brand_image.url(:small)
  json.brand_image_detail deal.brand_image.url(:gigantic)

  json.detail_url api_detail_url(deal, format: :json)

end