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

  protected

  def school_year_end_cannot_be_before_school_year_begin
    return if self.school_year_end > self.school_year_begin
    self.errors.add(:school_year_end, 'cannot be before school year begin')
  end

end
