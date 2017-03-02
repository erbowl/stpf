module ApplicationHelper
  def user_img(user)
    image_path = user.image.presence || '/noimage.png'
    haml_tag(:img,src:image_path)
  end
  def page_title
    title = "勉強垢図鑑"
    title = @page_title + " | " + title if @page_title
    title
  end
end
