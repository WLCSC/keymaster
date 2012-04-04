class NameValidator < ActiveModel::Validator
	def validate record
		if (Person.where(:first_name => record.first_name.upcase).where(:last_name => record.last_name.upcase).count > 0)
			record.errors[:base] << "This person has a duplicate name."
		end
	end
end

class Person < ActiveRecord::Base
	has_many :keyrings
	has_many :keys, :through => :keyrings
	accepts_nested_attributes_for :keys
	before_save 'cap_names'
	before_create 'fix_keys'
	validates_with NameValidator
 
	attr_accessor :key_list

	def name
		self.first_name + ' ' + self.last_name
	end

	def key_list
		s = ''
		self.keys.each do |k|
			s << "#{k.code}/#{k.notes.first ? k.notes.first.content : 'No comment'}\n"
		end
		s
	end

	def key_list= key_list
		if not key_list.empty?
			key_list.lines.each do |line|
				l = line.upcase.split('/')
				key = Key.where(:code => l[0]).first || Key.create!(:code => l[0])
				note = Note.create!(:content => l[1])
				puts key
				key.notes << note
				self.keys << key
				key.save
				note.save	
			end
		end
	end

	private

	def fix_keys
		key_list= self.key_list
	end

	def cap_names
		self.first_name.upcase!
		self.last_name.upcase!
	end
end

