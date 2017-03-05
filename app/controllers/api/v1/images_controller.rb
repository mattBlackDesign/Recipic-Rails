class Api::V1::ImagesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :check_authentication

  # include Serializers::V1::ItemsSerializer

  # Just skip the authentication for now
  # before_filter :authenticate_user!

  respond_to :json

  def photo_identify
    tag_response = ClarifaiRuby::TagRequest.new.get("https://samples.clarifai.com/metro-north.jpg")
  end

  private


    def check_authentication
       if User.where(authentication_token: params[:auth_token]).count == 1
        @user = User.where(authentication_token: params[:auth_token]).first
       else
        render :status => 401,
               :json => { :success => false,
                          :info => "Authentication failed",
                          :data => {} }
       end

   end

end