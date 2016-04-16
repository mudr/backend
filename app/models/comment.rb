class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post

	validates_presence_of :user_id, :post_id

	# 		########### Begin Paperclip stuff ############
	# has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
 #  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	# ########### End Paperclip stuff ############
end
