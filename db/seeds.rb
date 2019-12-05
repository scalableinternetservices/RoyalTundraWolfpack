posts = []
childcomments = []
parentcomments= []
users = []
books = []

i = 0
while i < 100
  user = User.new(email: i.to_s + "@seed.com", username: "seed" + i.to_s, password: "asdasd", password_confirmation: "asdasd")
  users << user
  i += 1
end

User.import users, validate: false

i = 0
while i < 50
  book = Book.new(title: "seedbook" + i.to_s, author: "author" + i.to_s)
  books << book
  i += 1
end

Book.import books, validate: false


users.each do |user|
  books.each do |book|
    j = 0
    while j < 1
      post = Post.new(title: user.username + "_" + j.to_s, author: user.id, content: "content", book_id: book.id)
      # puts "post:" + post.title
      posts << post

      j += 1
    end
  end
end

Post.import posts, validate: false

pc_count = 0
#comments
(0..9).each do |user_id|
  posts.each do |post|
    parent_count = 0
    while parent_count < 1
      parent_comment = Comment.new(body: "comment_body", commentable_id: post.id, commentable_type: "Post", user_id: user_id)
      # puts "pcomment: " + parent_comment.commentable_id.to_s
      parentcomments << parent_comment
      parent_count += 1
    end
    pc_count += 1
    # puts "pcomment count: " + pc_count.to_s
  end
end
Comment.import parentcomments, validate: false


cc_count = 0
# users.each do |user|
(0..1).each do |user_id|
  parentcomments.each do |parent_comment|
    k = 0
    while k < 2
      child_comment = Comment.new(body: "comment_body", commentable_id: parent_comment.id, commentable_type: "Comment", user_id: user_id)
      # puts "ccomment: " + child_comment.commentable_id.to_s
      childcomments << child_comment
      # puts "ccomment count: " + k.to_s
      k += 1
      cc_count += 1
      # puts "ccomment count: " + cc_count.to_s
    end
  end
end

Comment.import childcomments, validate: false

users.each do |sender|
  users.each do |receiver|
    if sender != receiver
      ongoing_conversation = Mailboxer::Conversation.between(receiver, sender).find{|c| c.participants.count == 2 }
      if !ongoing_conversation.present?
        receipt = sender.send_message(receiver, messageList.sample, "default-subject")
      end
    end
  end
end

users.each do |sender|
  count = 10
  users.reverse_each do |receiver|
    if count < 0
      break
    end
    if sender != receiver
      ongoing_conversation = Mailboxer::Conversation.between(receiver, sender).find{|c| c.participants.count == 2 }
      if ongoing_conversation.present?
        i = 0
        while i < 10
          receipt = sender.reply_to_conversation(ongoing_conversation, messageList.sample)
          i += 1
        end
      end
      count -= 1
    end
  end
end