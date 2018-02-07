class Picture < ApplicationRecord

	def self.create_picture(params)
		image_id = params[:image_id].split('#')[0].split('/').last
		name = params[:name]
		self.create(path: image_id, name: name)
	end
end
