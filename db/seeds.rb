posts = []
childcomments = []
parentcomments= []
users = []
books = []

USERS = 100
BOOKS = 50

i = 0
columns = [ :email, :username, :password]
while i < USERS
  # u = [i.to_s + "@seed.com", "seed" + i.to_s, "asdasd"]
  # puts u
  users << [i.to_s + "@seed.com", "seed" + i.to_s, "asdasd"]
  i += 1
end

User.import columns, users, validate: false

i = 0
columns = [ :title, :author ]
while i < BOOKS
  books << ["seedbook" + i.to_s, "author" + i.to_s] 
  i += 1
end

Book.import columns, books, validate: false


columns = [:title, :author, :content, :book_id]
(1..USERS).each do |user_id|
  (1..BOOKS).each do |book_id|
    k = 0
    while k < 1
      posts << ["post_title" + j.to_s, user_id, "content", book_id]
      k += 1
    end
  end
end

Post.import columns, posts, validate: false

MAX_USER_POST = 10
MAX_POSTS = USERS*BOOKS;
columns = [:body, :commentable_id, :commentable_type, :user_id]
(1..MAX_USER_POST).each do |user_id|
  (1..MAX_POSTS).each do |post_id|
    k = 0
    while k < 1
      parentcomments << ["comment_body", post_id, "Post", user_id]
      k += 1
    end
  end
end
Comment.import columns, parentcomments, validate: false


MAX_USERS_P_COMMENT = 2 
MAX_P_COMMENTS = MAX_USER_POST*MAX_POSTS
columns = [:body, :commentable_id, :commentable_type, :user_id]
(1..MAX_USERS_P_COMMENT).each do |user_id|
  (1..MAX_P_COMMENTS).each do |parent_comment_id|
    k = 0
    while k < 2
      childcomments << ["comment_body", parent_comment_id, "Comment", user_id]
      k += 1
    end
  end
end

Comment.import columns, childcomments, validate: false

(1..USERS).each do |sender_id|
  (1..USERS).each do |receiver_id|
    if sender_id != receiver_id
      sender = User.find(sender_id)
      receiver = User.find(receiver_id)
      ongoing_conversation = Mailboxer::Conversation.between(receiver, sender).find{|c| c.participants.count == 2 }
      if !ongoing_conversation.present?
        receipt = sender.send_message(receiver, "seed-message", "default-subject")
      end
    end
  end
end

(1..USERS).each do |sender_id|
  count = 10
  (1..USERS).reverse_each do |receiver_id|
    if count < 0
      break
    end
    if sender_id != receiver_id
      sender = User.find(sender_id)
      receiver = User.find(receiver_id)
      ongoing_conversation = Mailboxer::Conversation.between(receiver, sender).find{|c| c.participants.count == 2 }
      if ongoing_conversation.present?
        i = 0
        while i < 10
          receipt = sender.reply_to_conversation(ongoing_conversation, "seed-reply")
          i += 1
        end
      end
      count -= 1
    end
  end
end