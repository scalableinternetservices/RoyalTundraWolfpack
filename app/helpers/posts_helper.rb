module PostsHelper
  def getAuthorById(id)
    auth = User.find(id)
    return auth ? auth.username :  "[Deleted]"
  end
end
