class UserObserver < ActiveRecord::Observer
  def before_validation(user)
    user.location = Location.where(place_id: user.location.place_id).
      first_or_initialize do |l|
        [:latitude, :longitude, :country, :city, :name].each do |k|
          l.send("#{ k }=", user.location.send(k))
        end
      end
  end

  def after_save(user)
    user.location.save
    update_related_models
  end

  def after_destroy(user)
    update_related_models
  end

  def after_validation(user)
    case user.graduated
    when true
      user.graduating_class = GraduatingClass.where(
        year: user.year_end).first_or_create
    when false
      user.graduating_class = nil
    end
  end

  protected

  def update_related_models
    [Location, GraduatingClass].each do |klass|
      klass.find_each do |obj|
        obj.update_attributes(users_count: obj.users.count)
        obj.destroy if obj.users.size == 0
      end
    end
  end

end
