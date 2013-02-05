class MoviesController < ApplicationController
  def handle_state
	@all_ratings = ['G','PG','PG-13','R']  
	@hilite1 = @hilite2 = ""
	@items = Movie.all	
	@params = params
	@sort = params[:sort]
	@ratings = params[:ratings]
	if @ratings == nil			
		@ratings = Hash.new			
	else
		@items = Movie.where(:rating => @ratings.keys)
		@ratings_link = ""
		@ratings.keys.each do |rating|
			@ratings_link = @ratings_link + "ratings%5B#{rating}%5D=1&"
		end
	end	
	@none_selected = @ratings.length == 0	
  end
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
	handle_state
  end
  
  def index
	handle_state
	
	if @sort == "alpha"
		@hilite1 = "hilite"
		@items = @items.sort{|p1,p2| p1.title <=> p2.title}
	elsif @sort == "date"	
		@hilite2 = "hilite"
		@items = @items.sort{|p1,p2| p1.release_date <=> p2.release_date} 		
	end
		
	@movies = @items
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
