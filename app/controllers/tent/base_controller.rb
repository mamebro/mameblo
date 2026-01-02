class Tent::BaseController < ApplicationController
  if Rails.env.production? && ENV['BASIC_AUTH_USERNAME'].present?
    http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'],
                                 password: ENV['BASIC_AUTH_PASSWORD']
  end
end
