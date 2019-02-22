# Helper methods defined here can be accessed in any controller or view in the application

module Peluchero
  class App
    module ServerImagesHelper
      def name_and_description(server_image)
        text = server_image.name
        if server_image.description.present?
          text << " (#{server_image.description})"
        end

        text
      end
    end

    helpers ServerImagesHelper
  end
end
