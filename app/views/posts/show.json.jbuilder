json.post @post.title
json.post_content @post.content
json.post_mood @post.mood_at_time
json.active @post.active

json.array! @comments do |comment|
	json.comment_content comment.content
	json.user comment.user.username
	json.top_comment comment.top_comment
	json.created comment.created_at
	
end