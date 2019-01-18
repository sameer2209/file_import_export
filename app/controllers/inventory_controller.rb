class InventoryController < ApplicationController

	def new
	end

	def create
		params[:file].inspect
		@inventories = Inventory.all
		respond_to do |format|
			format.html { Inventory.import(params[:file]) }
			
			#redirect_to root_path, notice: "Inventory imported."
			format.csv { send_data @inventories.to_csv }
			format.xls { send_data @inventories.to_csv(col_sep: "\t") }
		end
	end

end
