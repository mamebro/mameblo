class Onsen < ActiveRecord::Base
  enum bathing: { ready: 0, relax: 1 }
end
