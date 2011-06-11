class Page < ActiveRecord::Base

	attr_accessible :title, :body, :private
	belongs_to :user
	
	validates :user_id, :presence => true
	validates :title, :presence => true
	validates :body, :presence => true
	
	
	
	def before_create
		@attributes['permalink'] = title.downcase.gsub(/\s+/,'_').gsub(/[^a-zA-Z0-9_]+/,'')
	end
	def to_param
		"#{id}-#{permalink}"
	end
	
end
