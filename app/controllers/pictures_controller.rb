class PicturesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:upload_picture, :generate_signature]
  CLOUDINARY_CONFIG = YAML.load(File.read("#{Rails.root}/config/cloudinary.yml"))

	def upload
		signedRequest = signature
		@signedRequest = signedRequest.to_json
		@pictures = Picture.all
	end

	def index
		redirect_to root_url
	end

	def create
		if params[:image_id].present? && params[:name].present?
			Picture.create_picture(picture_params)
		end
		redirect_to root_url
	end

	def generate_signature
		signedRequest = signature
		render :json => {:data => {api_key: signedRequest[:api_key],public_id: signedRequest[:public_id], timestamp: signedRequest[:timestamp], signature: signedRequest[:signature]}}
	end

	def upload_picture
		if params[:image_id].present? && params[:name].present?
			picture = Picture.create_picture(picture_params)
			render :json => {:message => picture}
		else
			render :json => {:message => 'Image Not uploaded'}
		end
	end

	private

	def picture_params
		return_value = params.permit(:image_id, :name)
	end

	def signature
		public_id = params[:public_id].present? ?  (params[:public_id].to_s + "_#{Time.now.to_i}")  : Time.now.to_i
		signedRequest = Cloudinary::Utils.sign_request({:public_id => public_id, :timestamp => Time.now.to_i}, :options=>{:api_key => CLOUDINARY_CONFIG[Rails.env]["api_key"], :api_secret => CLOUDINARY_CONFIG[Rails.env]["api_secret"]})
		signedRequest
	end
end