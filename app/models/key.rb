class Key < ActiveRecord::Base
	has_many :notes
	has_many :keyrings
	has_many :people, :through => :keyrings
	before_validation :cap_code
	#validates :code, :uniqueness => {:case_sensitive => false}
	attr_accessor :comment

	private

	def cap_code
		self.code.upcase!
		if self.comment && !self.comment.empty? 
			n = Note.create(:content => self.comment)
			self.notes << n if n
		end
	end
end
