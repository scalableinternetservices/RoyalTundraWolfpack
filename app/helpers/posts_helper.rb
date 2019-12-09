module PostsHelper
  def getAuthorById(id)
    begin 
      auth = User.find(id)
    rescue ActiveRecord::RecordNotFound
      return "[Deleted]"
    end
    return auth.username
  end

  def renderComments(postId)
    commentResults = Comment.where("post_id =  ?", postId)

    commentTree = { } # key: { (commentable_type, comment_id) => [comment1, comment2, comment3]}
    commentTree["(" + "Post" + "," + postId.to_s + ")"] = []
    commentResults.each do |comment|
      parentKey = "(" +  comment.commentable_type + "," + comment.commentable_id.to_s + ")"
      if(!commentTree.key?(parentKey))
        commentTree[parentKey] = []
      end
      commentTree[parentKey] << comment
    end
    
    
    result = ""
    commentTree["(" + "Post" + "," + postId.to_s + ")"].each do |comment|
      result += renderThread(commentTree, comment)  + "\n"
    end

    if commentTree["(" + "Post" + "," + postId.to_s + ")"].length == 0
      return "No comments to show"
    else
      return result
    end
  end

  def renderThread(commentTree, comment)
    childKey = "(" + "Comment"  + "," + comment.id.to_s + ")"
    if(!commentTree.key?(childKey))
      return _renderComment(comment, nil)
    end

    children = ""
    commentTree[childKey].each do |child|
      thread = renderThread(commentTree, child)
      if thread
        children += thread + "\n"
      end
    end

    return _renderComment(comment, children) 
  end

  def _renderComment(comment, children)
    #render comment, children: children
    render comment, children: children
  end
end
