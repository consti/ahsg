class GraduatingClass < ActiveRecord::Base
  has_many :users

  def to_s
    year.to_s
  end

  def to_param
    year.to_s
  end
end
