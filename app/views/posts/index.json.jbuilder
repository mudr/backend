json.array! @posts do |post|
	json.username post.user.username
	json.title post.title
	json.post_id post.id
end
