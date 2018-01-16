class LandmarksController < ApplicationController
    get '/landmarks' do

    @landmarks = Landmark.all
#binding.pry
      erb :'/landmarks/index'
    end
    get '/landmarks/new' do
        @landmarks = Landmark.all
        @titles = Title.all
        @figures = Figure.all
  #binding.pry
        erb :'/landmarks/new'
    end
    post '/landmarks' do
        #  binding.pry
          @landmark = Landmark.create(params[:landmark]) #create an obstantiate a new figure to the database.  This will also load the checkboxes for landmarks, and titles with saved relationships
          #binding.pry
          if params[:figure][:name] !="" # && params[:landmark][:year_completed] !=""
          #the 2nd condition above could be used with an alert, however the test cases are do not include adding the year when making a new landmark with a newfigure
          #ifthe landmark name and year input is filled than,
              figure = Figure.create(name: params[:figure][:name])
              @landmark.figure = figure

          end
          @landmarks = Landmark.all
          redirect "/landmarks/#{@landmark.id}"
    end
    get '/landmarks/:id' do
#binding.pry
      @landmark = Landmark.find_by(id: params[:id])
       erb :'/landmarks/show'
    end
    get '/landmarks/:id/edit' do
#binding.pry
      @landmark = Landmark.find_by(id: params[:id])
       erb :'/landmarks/edit'
    end
    post '/landmarks/:id' do

      @landmark = Landmark.find_by(id: params[:id])
      @landmark.update(params[:landmark])
#binding.pry
      redirect "/landmarks/#{@landmark.id}"

    end

end




#        post '/figures/:id' do
#          @figure = Figure.find_by(id: params[:id])
#          @figure.update(params[:figure]) #this will update the checkboxes as well
#          #binding.pry
#          if !!params[:landmark][:name]
#              landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
#              @figure.landmarks << landmark
#            end
#            if !!params[:title][:name]
#              title = Title.create(name: params[:title][:name])
#              FigureTitle.create(title_id: title.id, figure_id: @figure.id)
#            end
#            redirect "/figures/#{@figure.id}"
#          end
