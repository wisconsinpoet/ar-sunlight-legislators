require_relative '../app/models/legislator'
require_relative '../db/config'

# p Legislator.all.map(&:name)
# puts Legislator.all.map {|person| "#{person.name}, in office: #{person.in_office?}, #{person.phone}"}

# p Legislator.all.map {|person| person.state}

def by_state(state)
	sens = []
	reps = []
	Legislator.where("state = ?", state).each do |leg|
		if leg.title == "Sen"
			sens << "#{leg.name} (#{leg.party})"
		else
			reps << "#{leg.name} (#{leg.party})"
		end
	end
	puts "Senators:"
	puts sens
	puts "Representatives:"
	puts reps
end

def gender_count(gender)
	all_sens = Legislator.where(in_office: "1", title: "Sen").length
	gender_sens = Legislator.where(in_office: "1", title: "Sen", gender: gender).length
	sens_percent = "#{((gender_sens.to_f / all_sens) * 100).to_i} percent"
	all_reps = Legislator.where(in_office: "1", title: "Rep").length
	gender_reps = Legislator.where(in_office: "1", title: "Rep", gender: gender).length
	reps_percent = "#{((gender_reps.to_f / all_reps) * 100).to_i} percent"
	gender == "F" ? gender = "Female" : gender = "Male"
	puts "#{gender} Senators: #{gender_sens} (#{sens_percent})"
	puts "#{gender} Representatives: #{gender_reps} (#{reps_percent})"
end

def count_by_state
	Legislator.group("state").each do |place|
		sen_count = Legislator.where(in_office: "1", title: "Sen", state: place.state).count
		rep_count = Legislator.where(in_office: "1", title: "Rep", state: place.state).count
		puts "#{place.state}: #{sen_count} senators, #{rep_count} representatives"
	end
end

def total_legs_count
	sen_count = Legislator.where(title: "Sen").count
	rep_count = Legislator.where(title: "Rep").count
	puts "Senators: #{sen_count}"
	puts "Representatives: #{rep_count}"
end

total_legs_count

def delete_inactive
	Legislator.where(in_office: "0").each {|leg| leg.delete}
end

delete_inactive
total_legs_count

# count_by_state
# by_state("AL")
# gender_count("M")
# gender_count("F")