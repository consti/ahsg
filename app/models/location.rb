class Location < ActiveRecord::Base
  validates :place_id, presence: true, uniqueness: true
  validates :latitude, :longitude, presence: true
  validates :country, :city, :name, presence: true
  has_many :users

  def to_s
    "#{ city }, #{ country }"
  end

  def to_param
    "#{ id }-#{ self.to_s.parameterize }"
  end
end
