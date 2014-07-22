class Location < ActiveRecord::Base
  validates :place_id, presence: true, uniqueness: true
  validates :latitude, :longitude, presence: true
  validates :country, :city, :name, presence: true
end
