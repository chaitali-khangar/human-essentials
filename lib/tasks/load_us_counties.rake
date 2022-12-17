require 'csv'
namespace :db do
  desc "Load US Counties"
  task :load_us_counties => :environment do
    if County.find_by(name:"Abbeville County", region: " South Carolina").nil?
      puts 'loading US counties.  '
      counties = []
      CSV.foreach("lib//assets//us_county_list.csv") do |row|
        counties<< {name: row[0], region: row[1]}
      end

      columns = [:name, :region]
      County.import(columns, counties)
    end
  end
end