require 'csv'
require_relative '../app/models/legislator'



class SunlightLegislatorsImporter
  FIELDS = ['title', 'firstname', 'state', 'middlename', 'lastname', 'name_suffix', 'phone', 'fax', 'website', 'webform', 'party', 'gender', 'twitter_id', 'birthdate', 'in_office']

  def self.import
    csv = CSV.new(File.open('db/data/legislators.csv'), :headers => true)
    csv.each do |person|
      args = {}
      FIELDS.each do |field|
        if field == "phone"
          args[field] = person[field].gsub!(/\W/, '') 
        else
          args[field] = person[field]
        end
      end
      Legislator.create!(args)
    end
  end
end



# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
