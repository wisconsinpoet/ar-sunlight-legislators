require_relative '../config'


class CreateLegislators  < ActiveRecord::Migration
	def change
		create_table :legislators do |t|
			t.string :title
			t.string :firstname
			t.string :middlename
			t.string :lastname
			t.string :name_suffix
			t.string :party
			t.string :gender
			t.string :state
			t.string :phone
			t.string :fax
			t.string :website
			t.string :webform
			t.date :birthdate
			t.string :twitter_id
			t.binary :in_office
			t.timestamps
		end
	end
end
