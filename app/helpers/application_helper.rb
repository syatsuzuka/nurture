module ApplicationHelper
  def add_image (course, filename, options={})
    if defined? course.photo.key
      cl_image_tag(course.photo.key, options)
    else
      image_tag(filename, options)
    end
  end
end
