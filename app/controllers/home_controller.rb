class HomeController < ApplicationController
  def index
    @programs = Program.all
  end
end
