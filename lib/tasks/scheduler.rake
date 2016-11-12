desc "This should schedule push notification with urban airship"
task :schedule_notifications => :environment do
  require 'tzinfo'
  require 'urbanairship'
 	UA = Urbanairship

	
	@push_notifications = Notification.where("scheduled = ? AND stop_scheduling = ?", false, false)
	#@push_notifications = Notification.where("scheduled = ? AND send_date > ?", false, Time.now)

	@push_notifications.each do |scheduled_pn|
		
		if (scheduled_pn.send_date + (1 * 60 * 60 * 48)) < Time.now #if send_date + 2 days is still less than the current time, the push notification will never be sent & should not be run again in the scheduler
			
			#set some field so that it doesn't get run again
			scheduled_pn.stop_scheduling = true
			scheduled_pn.save
			puts "expired deals have been removed"
		
		else
			unless scheduled_pn.device_token.blank? || scheduled_pn.time_zone.blank?
			#begin urban airship scheduler
		 
			#development app key: 7l4t2ffJQHy0dZKsaTNaUQ
  			#development master secret: o3vTeDBqQk-UvtEkXrbRZQ

  			#production app key: TYwgAAP5S-yisjnH4ZXe3A
  			#production master secret: -DmsIg_lQu-LbtlSjR9Bfw

				cl = UA::Client.new(key: 'TYwgAAP5S-yisjnH4ZXe3A', secret: '-DmsIg_lQu-LbtlSjR9Bfw')
 				push = cl.create_push
				push.audience = UA.device_token(scheduled_pn.device_token)
				push.notification = UA.notification(
					alert: scheduled_pn.alert, 
					ios: UA.ios(
        				alert: scheduled_pn.alert,
        				badge: '+1',
        				extra: {'user_id': scheduled_pn.user_id, 
        						'brand_image': scheduled_pn.brand_image.url(:medium), 
        						'campaign_name': scheduled_pn.campaign_name,
        						'campaign_url': scheduled_pn.campaign_url, 
        						'campaign_description': scheduled_pn.description, 
        						'expiration_date': scheduled_pn.expiration_date.in_time_zone(scheduled_pn.time_zone).strftime("%b %d at %l:%M%P %Z"), 
        						'promocode': scheduled_pn.promo_code
	        				}
    	    			)
				)
				push.device_types = UA.all

				#setting up time to send push notification
				tz = TZInfo::Timezone.get(scheduled_pn.time_zone) #sets up TZInfo with users timezone
    			pn_time_zone = tz.current_period #creates a variable using the TZInfo
    			pn_utc_offset = pn_time_zone.utc_total_offset #calculates the total offset from UTC & factors in daylight savings
    			send_time = (scheduled_pn.send_date - pn_utc_offset) #takes the scheduled time in UTC & adjusts to users time

    			puts "send_time:"
    			puts send_time
    			puts "Time.now:"
    			puts Time.now
    			puts "scheduled_pn.expiration_date:"
    			puts scheduled_pn.expiration_date

    			if send_time > Time.now && send_time <  scheduled_pn.expiration_date #only schedule if PN is in the future, otherwise, job will fail && only schedule if the send time is before the expiratin date of the deal
					#SCHEDULING	PN
					schedule = cl.create_scheduled_push
					schedule.push = push
					schedule.name = "optional name for later reference"
					schedule.schedule = UA.scheduled_time(send_time)
					response = schedule.send_push

					#set notifcation field scheduled to true
					scheduled_pn.scheduled = true
					scheduled_pn.save
					puts "Scheduled!"
				else 
					puts "Not Scheduled!"
				end
			end
		end
	end

  puts "THE SCHEDULER IS WORKING, MOTHA FUCKA!"

end