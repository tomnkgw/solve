class HomeController < ApplicationController
  def index
    @requests = Request.all
  end
  def kiyaku
  end
  def tokutei
  end
  def privacy
  end
  def contact
  end
  def guide
  end 
end
