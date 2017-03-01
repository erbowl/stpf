module ApplicationHelper
  def user_img(user)
    image_path = '/noimage.png'
    image_path = user.image unless user.image.blank?
    haml_tag(:img,src:image_path)
  end
end
