require 'digest'
class User < ActiveRecord::Base
	has_attached_file :image, :styles => {
		:medium => "128x128>",
		:small => "48x48>"
	},
	:path => ":rails_root/public/system/:class/:attachment/:id/:style/:filename",
	:url => "/system/:class/:attachment/:id/:style/:filename"
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation, :image
	
	
	has_and_belongs_to_many :roles
	
	has_many :pages, :dependent => :destroy
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :name, :presence => true,
					:length => {:maximum => 50},
					:uniqueness => true
	validates :email, :presence => true ,
					:format => { :with => email_regex },
					:uniqueness => true
	validates :password, :presence => true,
					:confirmation => true,
					:length => {:within => 6..40 }
					
    before_save	:encrypt_password
	
	
	
	def has_role?(rolename)
		return self.roles.find_by_name(rolename)
	end
	
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
    end
	
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil  if user.nil?
		return user if user.has_password?(submitted_password)
	end
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	  end
	private
	
		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end
		
		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		def make_salt
		  secure_hash("#{Time.now.utc}--#{password}")
		end

		def secure_hash(string)
		  Digest::SHA2.hexdigest(string)
		end
end
