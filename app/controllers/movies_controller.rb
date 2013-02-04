class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
	@hilite1 = ""
	@hilite2 = ""	
	sort = params[:sort]
	if sort == "alpha"
		@hilite1 = "hilite"
		items = Movie.all.sort{|p1,p2| p1.title <=> p2.title}
	elsif sort == "date"	
		@hilite2 = "hilite"
		items = Movie.all.sort{|p1,p2| p1.release_date <=> p2.release_date} 		
	elsif		
		items = Movie.all
	end
		
	@movies = items
  end
  
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
