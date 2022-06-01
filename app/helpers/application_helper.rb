module ApplicationHelper
  def add_image (course, filename, classname)
    if defined? course.photo.key
      cl_image_tag(course.photo.key, class: classname)
    else
      image_tag('No image.png', class: classname)
    end
  end
end
