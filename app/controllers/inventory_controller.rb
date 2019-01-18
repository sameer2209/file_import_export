class InventoryController < ApplicationController

	def new
	end

	def create
		params[:file].inspect
		@inventories = Inventory.all
		respond_to do |format|
			format.html { @import_errors = Inventory.import(params[:file])}

			#redirect_to root_path, notice: "Inventory imported."
			format.csv { send_data @inventories.to_csv }
			format.xls { send_data @inventories.to_csv(["serial_number", "volume"],col_sep: "\t") }
		end
	end

end
