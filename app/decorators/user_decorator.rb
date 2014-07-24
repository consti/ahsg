class UserDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #

  def coordinates
    [object.latitude, object.longitude].join(', ')
  end

  def static_map(width: 400, height: 150, zoom: 7)
    url = URI.parse("http://maps.googleapis.com/maps/api/staticmap")
    url.query = URI.encode_www_form(
      center: coordinates,
      zoom: zoom,
      size: "#{ width }x#{ height }",
      maptype: 'roadmap',
      markers: 'size:mid|color:red|'+ coordinates
      )
    h.image_tag(url)
  end

  def profession
    return unless object.profession?
    h.content_tag :span, class: 'profession' do
      object.profession
    end
  end

  def title
    return unless object.title?
    h.content_tag :span, class: 'title' do
      object.title
    end
  end

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

  def boarding_school_tag
    { text: 'Internatsschüler', class: 'boarding_school_tag' }
  end

  def graduated_tag
    { text: 'Abi in Hogau', class: 'graduated_tag' }
  end

  def tags
    tags = []
    tags << boarding_school_tag if object.was_in_boarding_school?
    tags << graduated_tag if object.graduated?
    return unless tags.any?
    h.content_tag :ul, class: 'tags' do
      h.safe_join(
        tags.map { |tag| h.content_tag(:li, tag[:text], class: tag[:class]) })
    end
  end

  def age
    return unless object.date_of_birth?
    h.content_tag :span, class: 'age' do
      h.raw(Time.now.year - object.date_of_birth.year)
    end
  end

  def year_of_birth
    return unless object.date_of_birth?
    h.content_tag(:span, object.date_of_birth.year, class: 'year')
  end

  def nick_name
    return unless object.nick_name?
    h.content_tag :span, object.nick_name, class: 'nick_name'
  end

  def name_with_nick_name
    h.safe_join([object.first_name, nick_name, object.last_name].compact, ' ')
  end

  def name_with_title
    h.safe_join([title, user.to_s], ' ')
  end
end
