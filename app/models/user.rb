require 'ahsg/utilities'
class User < ActiveRecord::Base
  TITLES = ["BA", "BSc", "DI", "DI Dr.", "DI FH", "DI Mag.", "Dkfm.", "Dr.",
            "Ing.", "MA", "Mag.", "Mag. Dr.", "Mag. FH", "MAS", "MBA", "MD",
            "MMag.", "MMag. Dr.", "PhD.", "Prof.", "Prof. Dr.", "Univ.-Prof.",
            "Univ.-Prof. Dr."].sort

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, presence: true
  validates :school_year_begin, :school_year_end, presence: true
  validate :school_year_end_cannot_be_before_school_year_begin
  validates :title,
            inclusion: { in: TITLES, message: "%{value} is not a valid title" },
            allow_blank: true

  belongs_to :location, counter_cache: true
  belongs_to :graduating_class, counter_cache: true
  accepts_nested_attributes_for :location

  before_validation :set_existing_location
  after_validation :set_graduation_class

  mount_uploader :avatar, AvatarUploader

  delegate :latitude, :longitude, to: :location

  scope :attended_in, ->(arg) {
    range = Ahsg::Utilities.arg_to_range(arg)
    where("school_year_begin <= :r_end AND "\
          ":r_begin <= school_year_end", r_end: range.end, r_begin: range.first)
  }

  def location
    super || build_location
  end

  def time_at_school
    year_begin - year_end
  end

  def year_begin
    school_year_begin.year
  end

  def year_end
    school_year_end.year
  end

  def to_s
    "#{ first_name } #{ last_name}"
  end

  def to_param
    "#{ id }-#{ self.to_s.parameterize }"
  end

  protected

  def set_graduation_class
    case graduated
    when true
      self.graduating_class = GraduatingClass.where(
        year: Date.new(year_end, 1, 1)).first_or_create
    when false
      self.graduating_class = nil
    end
  end

  def set_existing_location
    self.location = Location.where(place_id: location.place_id).
      first_or_create do |l|
        [:place_id, :latitude, :longitude, :country, :city, :name].each do |k|
          l.send("#{ k }=", location.send(k))
        end
      end
  end

  def school_year_end_cannot_be_before_school_year_begin
    return if self.school_year_end > self.school_year_begin
    self.errors.add(:school_year_end, 'cannot be before school year begin')
  end
end
