class FiguresController < ApplicationController
  get '/figures' do
 #binding.pry
      @figures = Figure.all
      erb :'/figures/index'
  end
  get '/figures/new' do
      @landmarks = Landmark.all
      @titles = Title.all
      @figures = Figure.all
#binding.pry
      erb :'/figures/new'
  end
  get '/figures/:id' do

      @figure = Figure.find_by(id: params[:id])
#binding.pry
      erb :'figures/show'
  end
  post '/figures' do  #receives data from the form on figures new erb
    #binding.pry
          @figure = Figure.create(params[:figure]) #create an obstantiate a new figure to the database.  This will also load the checkboxes for landmarks, and titles with saved relationships
#binding.pry
      		if params[:landmark][:name] !="" # && params[:landmark][:year_completed] !=""
          #the 2nd condition above could be used with an alert, however the test cases are do not include adding the year when making a new landmark with a newfigure
          #ifthe landmark name and year input is filled than,
        			landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
              @figure.landmarks << landmark
          end

          if params[:title][:name] !=""  #checks to make sure the title was not left blank, if info was included in title than we want  to create a new title
              title = Title.create(name: params[:title][:name])
              @figure.titles << title
          end

      		redirect "/figures/#{@figure.id}"
  end
  get '/figures/:id/edit' do

      @figure = Figure.find_by(id: params[:id])
#binding.pry
      erb :'figures/edit'
  end
  post '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    @figure.update(params[:figure]) #this will update the checkboxes as well
#binding.pry
    if !!params[:landmark][:name]
        landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
        @figure.landmarks << landmark
    end
    if !!params[:title][:name]
      title = Title.create(name: params[:title][:name])
      FigureTitle.create(title_id: title.id, figure_id: @figure.id)
    end
    redirect "/figures/#{@figure.id}"
  end

end


#make sure you active the controllers in the config.ru file
