module ApplicationHelper
  def add_image (course, filename, options={})
    if defined? course.photo.key
      cl_image_tag(course.photo.key, options)
    else
      image_tag(filename, options)
    end
  end

  def due_alert (assignment)
    unless assignment.end_date.nil?
      if (assignment.end_date - Date.today).to_i < 10 && (assignment.end_date - Date.today).to_i > 0
        distance_of_time_in_words(Time.now, assignment.end_date + 1) + " left"
      end
    end
  end
end
