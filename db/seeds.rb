# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
MessageList = [
  ["Hello, how are you"],
]

#Create 100 users
users = []
books = []

i = 0
while i < 30
  user = User.create(email: i.to_s + "@seed.com", username: "seed" + i.to_s, password: "asdasd", password_confirmation: "asdasd")
  book = Book.create(title: "seedbook" + i.to_s, author: "author" + i.to_s)
  users << user
  books << book
  i += 1
end

User.all.each do |user|
  Book.all.each do |book|
    j = 0
    while j < 10
      post = Post.create(title: j.to_s + user.username, author: user.id, content: "content", book_id: book.id)

      parent_count = 0
      while parent_count < 1
        parent_comment = Comment.create(body: "content", commentable_id: post.id, commentable_type: "Post", user_id: user.id)

        k = 0
        while k < 1
          child_comment = Comment.create(body: "child_content", commentable_id: parent_comment.id, commentable_type: "Comment", user_id: user.id)
          k += 1
        end

        parent_count += 1
      end
      j += 1
    end
  end
end