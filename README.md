# README

This README would normally document whatever steps are necessary to get the
application up and running.

* Deployment instructions

* How to check this application
* setup by using bundle install and rake db:setup
* goto localhost:3000 and you will see a home page with form to enter image name and select image file
* If you want to call this as API endpoint : http://localhost:3000/pictures/upload_picture
* Request Type POST, Parameters name & image_id where image_id is that data which is returned back by cloudinary upload.

* To generate signature : Call END POINT http://localhost:3000/pictures/generate_signature
* Request Type : POST
* Input is public_id this id is unique public identifier for the uploaded image. we are making this id as unique by adding timestamp to it.

* OUTPUT 

{
	data: {
	public_id: "entered_public_id_TIMESTAMP",
	timestamp: 1505797744,
	signature: "GENERATED_SIGNATURE",
	api_key: "API_KEY"
	}
}