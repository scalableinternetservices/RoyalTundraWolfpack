module BooksHelper
  def getAuthorById(id)
    begin 
      auth = User.find(id)
    rescue ActiveRecord::RecordNotFound
      return "[Deleted]"
    end
    return auth.username
  end

  def truncate_content(content)
    if content.length <= 200
      return content
    else
      s = content.split(" ").each_with_object("") {|x,ob| break ob unless (ob.length + " ".length + x.length <= 200);ob << (" " + x)}.strip
      return s + "..."
    end
  end
end
