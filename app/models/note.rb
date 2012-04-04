class Note < ActiveRecord::Base
	belongs_to :key
	before_save :cap_content
	#validates :content, :uniqueness => {:case_sensitive => false}

	private

	def cap_content
		self.content.upcase!
	end
end
