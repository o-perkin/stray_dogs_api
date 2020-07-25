class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include SendingEmails
end
 