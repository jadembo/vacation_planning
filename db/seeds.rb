# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib','seeds','requests.csv'))
csv = CSV.parse(csv_text,:headers=>true, :encoding => 'ISO-8859-1')
csv.each do |row|
  r=Request.new
  r.user_id = row['user_id']
  r.allotment_id = row['allotment_id']
  r.length = row['length']
  r.request_type = row['request_type']
  r.save

  puts "#{r.user_id}, #{r.allotment_id} saved"

end
