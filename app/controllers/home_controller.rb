class HomeController < ApplicationController
  def index
    @title = "Detective"
    @id = "home"
  end
  
  def landing
    @title    = "Detective"
    @body_id  = "landing"
  end
end
