class Api::V1::MainController < ApplicationController
  require 'mini_magick'
    SUPPORTED_FILE_TRANSITIONS = {
      image: ["jpeg", "jpg", "png", "gif", "bmp", "tiff", "tif", "svg", "webp"],
      video: ["mp4", "avi", "mov", "mkv", "flv", "wmv", "webm", "mpeg", "mpg"],
      font: ["ttf", "otf", "woff", "woff2", "eot", "svg"]
    }
    def convert
      file = convert_params[:file]
      return render json: { error: "file should be passed"} unless file
      content_type = file.content_type
      case content_type
      when /\Aimage\//
        begin
          tempfile = file.tempfile
          img = MiniMagick::Image.open(tempfile.path)
          
          img.format "png"
          output_path = Rails.root.join('public', 'uploads', "converted_image_01.png")
          img.write(output_path)
          
          url = request.base_url + '/uploads/converted_image_01.png'

          render json: { url: url }

        rescue MiniMagick::Error => e
          render json: { error: "Error processing image: #{e.message}" }, status: :unprocessable_entity
        end
      when /\Avideo\//
        render json:  "This is a video file"
      when /\Afont\//
        render json:  "This is a font file"
      else
        render json:  "Unknown file type"
      end


      # if params[:image].present?
      # else
      #   render json: { error: "No image uploaded!" }, status: :unprocessable_entity
      # end
    end
    def convert_params
      params.require(:converter).permit(:file, :convert_to)
    end
    
end
