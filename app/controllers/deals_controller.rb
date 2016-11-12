class DealsController < ApplicationController
	def update
    	@deal = Deal.find(params[:id])
    	@deal.update(display: false)
    	redirect_to root_path
	end

	def show
		@deal = Deal.find(params[:id])
	end
end
