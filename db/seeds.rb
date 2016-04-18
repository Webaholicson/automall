# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create(
  first_name: 'Antonio', last_name: 'Mendes',
  email: 'antonio@example.com', username: 'amendes',
  password: Digest::MD5.hexdigest(Base64.encode64('pass123')),
  active: true,
)
