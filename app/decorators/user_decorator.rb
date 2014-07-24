class UserDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  def avatar(size = :thumb)
    raise 'not a valid size' unless [:thumb, :profile].include?(size)
    if object.avatar?
      h.image_tag(object.avatar_url(size))
    else
      "No Avatar set."
    end
  end

  def member_since
    h.content_tag :span, class: 'member_since' do
      h.time_ago_in_words(object.created_at)
    end
  end

  def time_at_school
    h.content_tag :span, class: 'time_at_school' do
      h.safe_join([
        h.content_tag(
          :span,
          object.time_at_school,
          class: 'time_at_school years'),
        'years'], ' ')
    end
  end

  def school_years
    h.raw h.content_tag(:ul, class: 'school_years') {
      h.safe_join(
      [h.content_tag(:li, object.school_year_begin.year),
       h.content_tag(:li, object.school_year_end.year)])
    }
  end

  def name
    user
  end
end
