messageList = [
  ["Hello, how are you"],
  ["Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."],
  ["It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old."],
  ["Midway through the brilliant and deeply unsettling “Parasite,” a destitute man voices empathy for a family that has shown him none. “They’re rich but still nice,” he says, aglow with good will. His wife has her doubts. “They’re nice because they’re rich,” she counters. With their two adult children, they have insinuated themselves into the lives of their pampered counterparts. It’s all going so very well until their worlds spectacularly collide, erupting with annihilating force. Comedy turns to tragedy and smiles twist into grimaces as the real world splatters across the manicured lawn.
    The story takes place in South Korea but could easily unfold in Los Angeles or London. The director Bong Joon Ho (“Okja”) creates specific spaces and faces — outer seamlessly meets inner here — that are in service to universal ideas about human dignity, class, life itself. With its open plan and geometric shapes, the modernist home that becomes the movie’s stage (and its house of horrors) looks as familiar as the cover of a shelter magazine. It’s the kind of clean, bright space that once expressed faith and optimism about the world but now whispers big-ticket taste and privilege."],
  ["Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."],
  ["It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old."],
  ["Take being the operative word. The other Kims don’t secure their positions as art tutor, housekeeper and chauffeur, they seize them, using lies and charm to get rid of the Parks’ other employees — including a longtime housekeeper (a terrifically vivid Lee Jung Eun) — in a guerrilla incursion executed with fawning smiles."]
]
contentList = [
  ["Midway through the brilliant and deeply unsettling “Parasite,” a destitute man voices empathy for a family that has shown him none. “They’re rich but still nice,” he says, aglow with good will. His wife has her doubts. “They’re nice because they’re rich,” she counters. With their two adult children, they have insinuated themselves into the lives of their pampered counterparts. It’s all going so very well until their worlds spectacularly collide, erupting with annihilating force. Comedy turns to tragedy and smiles twist into grimaces as the real world splatters across the manicured lawn.
    The story takes place in South Korea but could easily unfold in Los Angeles or London. The director Bong Joon Ho (“Okja”) creates specific spaces and faces — outer seamlessly meets inner here — that are in service to universal ideas about human dignity, class, life itself. With its open plan and geometric shapes, the modernist home that becomes the movie’s stage (and its house of horrors) looks as familiar as the cover of a shelter magazine. It’s the kind of clean, bright space that once expressed faith and optimism about the world but now whispers big-ticket taste and privilege."],
  ["Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."],
  ["It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old."],
  ["Take being the operative word. The other Kims don’t secure their positions as art tutor, housekeeper and chauffeur, they seize them, using lies and charm to get rid of the Parks’ other employees — including a longtime housekeeper (a terrifically vivid Lee Jung Eun) — in a guerrilla incursion executed with fawning smiles."]
]

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
      puts "post:" + post.title
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