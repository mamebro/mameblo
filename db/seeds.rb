require 'factory_bot'
# Dir[Rails.root.join('spec/support/factories/*.rb')].each {|f| require f }
Brother.delete_all
Entry.delete_all

FactoryBot.create_list(:brother, 200)
FactoryBot.create_list(:entry, 100)
