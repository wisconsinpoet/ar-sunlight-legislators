require_relative '../../db/config'


class Legislator < ActiveRecord::Base

  validates :phone, :format => { :with => /\d{3}(\s|\W){0,2}\d{3}(\s|\W){0,2}\d{4}/,
    :message => "invalid phone number" }, :if => :phone

	def name
		"#{title} #{firstname} #{lastname} #{name_suffix}"
	end

	def in_office?
		in_office == "1" ? true : false
	end

end
