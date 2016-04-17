json.post @post.title
json.post_content @post.content
json.post_mood @post.mood_at_time
json.active @post.active
json.point_given @post.point_given
json.comments @post.comments

json.array! @users do |user|
	json.username user.username
	json.points user.points
end