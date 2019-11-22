module PostsHelper
  def getAuthorById(id)
    begin 
      auth = User.find(id)
    rescue ActiveRecord::RecordNotFound
      return "[Deleted]"
    end
    return auth.username
  end
end
