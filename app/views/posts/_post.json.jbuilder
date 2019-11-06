json.extract! post, :id, :title, :author, :upvotes, :created_at, :updated_at
json.url post_url(post, format: :json)
