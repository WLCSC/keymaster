class Keyring < ActiveRecord::Base
	belongs_to :key
	belongs_to :person
end
