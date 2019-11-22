module PostsHelper
  def getAuthorById(id)
    begin 
      auth = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return "[Deleted]"
    end
    return auth.username
  end
end
