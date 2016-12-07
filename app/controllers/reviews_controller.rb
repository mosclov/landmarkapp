class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /reviews
  # GET /reviews.json
  def index
    redirect_to '/'
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @reviews = Review.find(params[:id])
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @feed_items = current_user.feed.paginate(page: params[:page])
    @review = Review.new(review_params)
    if @review.text.strip.empty?
      flash[:alert] = "Review cannot be blank!"
      redirect_to '/landmarks/'+ @review.landmark.id.to_s
    else
      respond_to do |format|
        if @review.save
          format.html { redirect_to '/landmarks/'+ @review.landmark.id.to_s, notice: 'Review was successfully created.' }
          format.json { render :show, status: :created, location: @review }
        else
          @feed_items = []
          format.html { render :new }
          format.json { render json: @review.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    # @review = Review.find(params[:id])
    # @landmark = @review.landmark
    @review.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:text, :landmark_id, :user_id)
    end

    def correct_user
      @review = current_user.reviews.find_by(id: params[:id])
      redirect_to root_url if @review.nil?
    end
end
