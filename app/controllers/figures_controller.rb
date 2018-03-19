class FiguresController < ApplicationController
  get '/figures' do #show all figures
    @figures = Figure.all
    erb :'/figures/index'
    # binding.pry
  end

end
