require 'roo'

class Inventory < ApplicationRecord
	
	validates :item_type, presence: true
	validates :sku, presence: true, uniqueness: true , format: {with: /[A-Z]{3}[0-9]{4}/}
	validates :Title, presence: true
	validates :serial_number, presence: true, uniqueness: true, format: {with: /[0-9]{15}/}
	validates :quantity, presence: true
	validates :price, presence: true
	validates :organization, presence: true
	validates :Length, presence: true
	validates :Breadth, presence: true
	validates :Height, presence: true
	validates :Weight, presence: true
	validates :description, presence: true
	validates :short_description, presence: true
	validates :asset_code, presence: true
	validates :grade, presence: true
	validates :category, presence: true
	validates :brand, presence: true

	def self.import(file)
		if File.extname(file.original_filename) == '.csv'
			puts "----------------------------inside csv"
			CSV.foreach(file.path, headers: true) do |row|
				puts row.inspect
				inventory = find_by_id(row["id"]) || new
				inventory.volume = row["Length"].to_f*row["Breadth"].to_f*row["Height"].to_f
				#inventory.volume = self.Length*self.Breadth*self.Height
				inventory.attributes = row.to_hash#.slice(*column_names)
				inventory.save
			end
		elsif File.extname(file.original_filename) == '.xls'
			puts "----------------------------inside xls"
			spreadsheet = open_spreadsheet(file)
			header = spreadsheet.row(1)
			header.push("volume")
			(2..spreadsheet.last_row).each do |i|
				r = spreadsheet.row(i)
				volume = r[7]*r[8]*r[9]
				r.push(volume)
				puts [header, r].transpose.inspect
				row = Hash[[header, r].transpose]
				puts row
				inventory = find_by_id(row["id"]) || new
				#inventory.volume = row["Length"]*row["Breadth"]*row["Height"]
				inventory.attributes = row.to_hash
				inventory.save
			end
		end
	end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
		when ".csv" then Csv.new(file.path, packed: nil, file_warning: :ignore)
		when ".xls" then Roo::Excel.new(file.path)
		when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
		else raise "Unknown file type: #{file.original_filename}"
		end
	end

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
    		all.each do |inventory|
      			csv << inventory.attributes.values_at(*column_names)
    		end
		end
	end


end
