class Api::V1::BlogController < ApplicationController

  def index
    @blog = Blog.all
  end
  
end
