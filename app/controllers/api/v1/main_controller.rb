class Api::V1::MainController < ApplicationController
  require 'mini_magick'
    
    def convert
      
      if params[:image].present?
        image = params[:image]
        
        begin
          # byebug
          tempfile = image.tempfile
          
          # Open the image using MiniMagick
          img = MiniMagick::Image.open(tempfile.path)
          
          # Change the format to PNG
          img.format "png"
          output_path = Rails.root.join('public', 'uploads', "converted_image.png")
          img.write(output_path)
          
          # Get the URL of the saved file
          url = request.base_url + '/uploads/converted_image.png'
          
          # Respond with the URL of the converted file
          render json: { url: url }

        rescue MiniMagick::Error => e
          # Handle MiniMagick errors
          render json: { error: "Error processing image: #{e.message}" }, status: :unprocessable_entity
        end
      else
        render json: { error: "No image uploaded!" }, status: :unprocessable_entity
      end
    end
end
