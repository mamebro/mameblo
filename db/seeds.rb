# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_name = "しかくん"
content_msg = "テンションあがってきた"

20.times do |i| 
  User.create( name: "#{user_name}#{i}号" )
  Entry.create( user_id: i, title: "テンションが#{i}あがった", content: content_msg * i )
end
