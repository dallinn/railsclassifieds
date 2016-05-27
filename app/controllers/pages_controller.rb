class PagesController < ApplicationController
	def home
		@posts = Post.limit(3).order('id desc')
	end
end
