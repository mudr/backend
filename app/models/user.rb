class User < ActiveRecord::Base
	has_secure_password

	has_many :posts
	has_many :comments

		validates :email, presence: true, uniqueness: true,
		format: {
			with: /.+\@.+\..+/,
			message: "USE VALID EMAIL FORMAT."
		}
	validates :auth_token, presence: true
	validates :mood, presence: true,
	inclusion: {
		in: 1..2,
		message: "MOOD IS EQUAL TO 1 THROUGH 2"
	}
	validates :username, presence: true, uniqueness: true, length: { minimum: 4,
	message: "USERNAME MUST BE 4 OR MORE CHARACTERS" }

	########### Begin Paperclip stuff ############
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
	########### End Paperclip stuff ############


	def ensure_auth_token
		unless self.auth_token
			self.auth_token = User.generate_token
		end
	end

	def self.generate_token
		token = SecureRandom.hex
		while User.exists?(auth_token: token)
			token = SecureRandom.hex
		end
		token
	end

end
