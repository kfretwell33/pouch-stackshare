json.deal_id @deal.id
  
json.campaign_name @deal.campaign.campaign_name
json.description @deal.campaign.description
json.campaign_url @deal.campaign.campaign_url

json.expiration_date @deal.campaign.expiration_date.in_time_zone(@deal.time_zone).strftime("%B %d at %l:%M%P")

json.promocode @deal.campaign.promo_code
json.campaign_id @deal.campaign_id

json.brand_name @deal.campaign.brand.brand_name
json.brand_image @deal.brand_image.url(:medium)
