class LandmarksController < ApplicationController
  before_action :set_landmark, only: [:show, :edit, :update, :destroy]

  # GET /landmarks
  # GET /landmarks.json
  def index
    @landmarks = Landmark.all
  end

  def map_locations
    #if the user has entered a zipcode
    if params[:zipcode].present?

      zipcode = params[:zipcode]
      #find all landmarks whose address has this zipcode and display them on the search page map
      @landmarks = Landmark.near(params[:zipcode], 10, :order => false)
      @hash = Gmaps4rails.build_markers(@landmarks) do |landmark, marker|
        if landmark.longitude.nil? || landmark.latitude.nil?
          marker.lat(-1)
          marker.lng(-1)
          marker.infowindow("<em>" + landmark.name + landmark.address + "</em>")
        else
          marker.lat(landmark.latitude)
          marker.lng(landmark.longitude)
          marker.picture({
            :url => ActionController::Base.helpers.asset_path('map-icon.png'),
            :height => 36,
            :width => 36
            });
          marker.infowindow("<em>" + ActionController::Base.helpers.link_to(ActionController::Base.helpers.image_tag(landmark.image.url(:large)), landmark.image.url) + "<br>"+ landmark.name + "
          <br> " + landmark.address + "<br> " + "<a href='/landmarks/#{landmark.id.to_s}'>" "Show More...</a></em>")
        end
      end
      render json: @hash.to_json
      #otherwise display all landmarks on the welcome page map.
    else
      @landmark = Landmark.all
      @hash = Gmaps4rails.build_markers(@landmark) do |landmark, marker|
        if landmark.longitude.nil? || landmark.latitude.nil?
          marker.lat(-1)
          marker.lng(-1)
          marker.infowindow("<em>" + landmark.name + landmark.address + "</em>")
        else
          marker.lat(landmark.latitude)
          marker.lng(landmark.longitude)
          marker.picture({
            :url => ActionController::Base.helpers.asset_path('map-icon.png'),
            :height => 36,
            :width => 36
            });
          marker.infowindow("<em>" + ActionController::Base.helpers.link_to(ActionController::Base.helpers.image_tag(landmark.image.url(:large)), landmark.image.url) + "<br>"+ landmark.name + "
          <br> " + landmark.address + "<br> " + "<a href='/landmarks/#{landmark.id.to_s}'>" "Show More...</a></em>")
        end
      end
      render json: @hash.to_json
    end
end

  #finds the location for a particular landmark by id
  def map_location
  @landmark = Landmark.find(params[:id])
  @hash = Gmaps4rails.build_markers(@landmark) do |landmark, marker|
      marker.lat(landmark.latitude)
      marker.lng(landmark.longitude)
      marker.picture({
        :url => ActionController::Base.helpers.asset_path('map-icon.png'),
        :height => 36,
        :width => 36
        });
      marker.infowindow("<em>" + landmark.address + "</em>")
    end
    render json: @hash.to_json
  end

  # GET /landmarks/1
  # GET /landmarks/1.json
  def show
    @review = Review.new
    # @landmark = Landmark.find(params[:id])
    @review.landmark = @landmark
    @star_ratings = StarRating.where(landmark_id: @landmark)
    @star_rating = StarRating.new

    if @star_ratings.blank?
      @avg_rating = 0
    else
      @avg_rating = @star_ratings.average(:rating).round(2)
    end

  end

  # GET /landmarks/new
  def new
    @landmark = Landmark.new
    @users_for_select = User.all.map do |user|
      [user.email, user.id]
    end
  end

  # GET /landmarks/1/edit
  def edit
  end

  # POST /landmarks
  # POST /landmarks.json
  def create
    @landmark = Landmark.new(landmark_params)

    respond_to do |format|
      if @landmark.save
        format.html { redirect_to @landmark, notice: 'Landmark was successfully created.' }
        format.json { render :show, status: :created, location: @landmark }
      else
        format.html { render :new }
        format.json { render json: @landmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /landmarks/1
  # PATCH/PUT /landmarks/1.json
  def update
    respond_to do |format|
      if @landmark.update(landmark_params)
        format.html { redirect_to @landmark, notice: 'Landmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @landmark }
      else
        format.html { render :edit }
        format.json { render json: @landmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /landmarks/1
  # DELETE /landmarks/1.json
  def destroy
    @landmark.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Landmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 #Textacular basic search for keywords in description attriute for landmarks
  def search_results
    @results = Landmark.search(params[:search])
    if @results.length == 0
      flash[:alert] = 'No match found! Please try again.'
      redirect_to '/'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_landmark
      @landmark = Landmark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def landmark_params
      params.require(:landmark).permit(:name, :description, :address, :website, :user_id, :image, :rating)
    end

    def review_params
      params.require(:review).permit(:text, :landmark_id, :user_id)
    end
end
