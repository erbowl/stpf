module ApplicationHelper
  def img_path(user)
    user.image.presence || '/noimage.png'
  end
  def page_title
    title = "勉強垢図鑑"
    title = @page_title + " | " + title if @page_title
    title
  end
end
