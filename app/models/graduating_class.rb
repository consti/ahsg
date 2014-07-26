class GraduatingClass < ActiveRecord::Base
  has_many :users
  has_many :comments, as: :commentable

  def to_s
    year.to_s
  end

  def to_param
    year.to_s
  end
end
