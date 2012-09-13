# -*- coding: utf-8 -*-

require 'factory_girl'
# Dir[Rails.root.join('spec/support/factories/*.rb')].each {|f| require f }
Brother.delete_all
Entry.delete_all

FactoryGirl.create_list(:brother, 200)
FactoryGirl.create_list(:entry, 100)