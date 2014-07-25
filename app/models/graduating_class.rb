class GraduatingClass < ActiveRecord::Base
  has_many :users
  after_update :auto_destroy_if_no_users

  def auto_destroy_if_no_users
    self.destroy if users.size == 0
  end

  def year
    super.year
  end

  def to_params
    "#{ id }-of-#{ year }"
  end
end
