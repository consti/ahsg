json.array!(@comments) do |comment|
  json.extract! comment, :id, :commentable_id, :text, :author_id
  json.url comment_url(comment, format: :json)
end
