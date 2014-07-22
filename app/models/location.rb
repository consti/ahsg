class Location < ActiveRecord::Base
  validates :google_place_id, presence: true, uniqueness: true
  validates :address, uniqueness: true, allow_blank: true
end
