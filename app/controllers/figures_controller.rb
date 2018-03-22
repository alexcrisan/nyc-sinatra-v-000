class FiguresController < ApplicationController
#Display all figures to user
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

#Display form to create new figure
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

#Receive new figure and details from form
  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    @figure.save
    redirect "/figures/#{@figure.id}"
  end

#Display single figure page with a particular id
  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

#Display page to edit single figure with particular id
  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/edit'
  end

#Receive new parameters from edit page and update the database
  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])
    if !params[:landmark][:name].empty?
      @landmark = Landmark.find_or_create(params[:landmark])
      @figure.landmarks << @landmark
    end
    @figure.save
    redirect("/figures/#{@figure.id}")
  end

end
