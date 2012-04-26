class FbHandlerController < ApplicationController
  respond_to :js
  require('typhoeus')
  
  def request_callback()
    fb_uids = params["to"]
    puts '[FB_UID]: ' + fb_uids.inspect
  end
  
end