# posts = []
# childcomments = []
# parentcomments= []
users = []
# books = []

USER_COUNT = 100
BOOK_COUNT = 50
POST_COUNT = USER_COUNT*BOOK_COUNT

USER_PARENT_COMMENT_CAP = 10
PARENT_COMMENT_COUNT = USER_PARENT_COMMENT_CAP*POST_COUNT

USER_CHILD_COMMENT_CAP = 2
CHILD_COMMENT_COUNT = USER_CHILD_COMMENT_CAP*PARENT_COMMENT_COUNT



uc = 0
i = 0
while i < USER_COUNT
  user = User.create(email: i.to_s + "@seed.com", username: "seed" + i.to_s, password: "asdasd", password_confirmation: "asdasd")
  users << user
  i += 1
  uc += 1
end

bc = 0
i = 0
while i < BOOK_COUNT
  Book.create(title: "seedbook" + i.to_s, author: "author" + i.to_s)
  i += 1
  bc += 1
end


pc = 0
i = 0
while i < USER_COUNT
  j = 0
  while j < BOOK_COUNT
    k = 0
    while k < 1
      Post.create(title: "seed_title" + i.to_s, author: i+1, content: "content", book_id: j+1)
      k+=1
      pc += 1
    end
    j+=1
  end
  i+=1
end 

pcc = 0 
i = 0
while i < USER_PARENT_COMMENT_CAP
  j = 0
  while j < POST_COUNT
    k = 0
    while k < 1
      Comment.create(body: "parent_comment_body", commentable_id: j+1, commentable_type: "Post", user_id: i+1)
      k += 1
      pcc += 1
    end
    j += 1
  end
  i += 1
end

ccc = 0
i = 0

while i < PARENT_COMMENT_COUNT
  j = 0
  while j < USER_CHILD_COMMENT_CAP
    k = 0
    while k < 2
      Comment.create(body: "child_comment_body", commentable_id: i+1, commentable_type: "Comment", user_id: j+1)
      k += 1
    end
    j += 1
  end
  i += 1
end


# while i < USER_CHILD_COMMENT_CAP
#   j = 0
#   while j < PARENT_
#     k = 0
#     while k < 2
#       Comment.create(body: "child_comment_body", commentable_id: j+1, commentable_type: "Comment", user_id: i+1)
#       k += 1
#       ccc += 1
#     end
#     j += 1
#   end
#   i += 1
# end

# Comment.import childcomments, validate: false

users.each do |sender|
  users.each do |receiver|
    if sender != receiver
      ongoing_conversation = Mailboxer::Conversation.between(receiver, sender).find{|c| c.participants.count == 2 }
      if !ongoing_conversation.present?
        receipt = sender.send_message(receiver, "seed message", "default-subject")
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
          receipt = sender.reply_to_conversation(ongoing_conversation, "seed reply")
          i += 1
        end
      end
      count -= 1
    end
  end
end