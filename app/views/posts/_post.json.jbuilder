#json.extract! post, :title, :content
json.merge! post.attributes
json.url post_url(post, format: :json)
