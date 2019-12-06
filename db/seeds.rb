starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
posts = []
childcomments = []
parentcomments= []
users = []
books = []

USERS = 100
BOOKS = 50

i = 0

while i < USERS
  user = User.new(email: i.to_s + "@seed.com", username: "seed" + i.to_s, password: "asdasd", password_confirmation: "asdasd") 
  users << user
  i += 1
end

User.import users, validate: false
puts "Seeded Users"

i = 0
columns = [ :title, :author ]
while i < BOOKS
  books << ["seedbook" + i.to_s, "author" + i.to_s] 
  i += 1
end

Book.import columns, books, validate: false
puts "Seeded Books"

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
puts "Seeded Posts"

MAX_USER_POST = 10
MAX_POSTS = USERS*BOOKS;
columns = [:body, :commentable_id, :commentable_type, :user_id, :post_id]
(1..MAX_USER_POST).each do |user_id|
  (1..MAX_POSTS).each do |post_id|
    k = 0
    while k < 1
      parentcomments << ["comment_body", post_id, "Post", user_id, post_id]
      k += 1
    end
  end
end
Comment.import columns, parentcomments, validate: false
puts "Seeded Parent Comments"


MAX_USERS_P_COMMENT = 2 
MAX_P_COMMENTS = MAX_USER_POST*MAX_POSTS
post_comment_list = Comment.pluck(:post_id)
pcl_index = 0
columns = [:body, :commentable_id, :commentable_type, :user_id, :post_id]
(1..MAX_P_COMMENTS).each do |parent_comment_id|
  (1..MAX_USERS_P_COMMENT).each do |user_id|
    k = 0
    while k < 2
      childcomments << ["comment_body", parent_comment_id, "Comment", user_id, post_comment_list[pcl_index]]
      # puts "Inserting child comment on post_id: " + post_comment_list[pcl_index].to_s
      k += 1
    end
  end
  pcl_index += 1
end

Comment.import columns, childcomments, validate: false
puts "Seeded Child Comments"
ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
elapsed = ending - starting
puts "Took " + elapsed.to_s + " sec to seed"