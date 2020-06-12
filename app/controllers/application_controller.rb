class ApplicationController < ActionController::Base
  include DeviseWhitelist
  def favorite_text
    return @favorite_exists ? "Remove from favorites" : "Add to favorites"
  end

  helper_method :favorite_text
end
 