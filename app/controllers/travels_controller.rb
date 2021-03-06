class TravelsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_travel, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  load_and_authorize_resource :only => [:index, :show]

  # GET /travels
  # GET /travels.json
  def index
    @travels = Travel.all
  end

  # GET /travels/1
  # GET /travels/1.json
  def show
  end

  # GET /travels/new
  def new
    @travel = Travel.new
  end

  # GET /travels/1/edit
  def edit
  end

  # POST /travels
  # POST /travels.json
  def create
    @travel = Travel.new(travel_params)
    # Check file before get
    if params[:travel][:file] != nil
      # Get file attached
      file_upload = params[:travel][:file]
      # Write file to public/files with original file name
      File.open(Rails.root.join('app/assets','images', file_upload.original_filename), "wb") do |file| 
         file.write(file_upload.read)
      end
      # Set name file to create to DB
      @travel.file = file_upload.original_filename
    end

    respond_to do |format|
      if @travel.save
        format.html { redirect_to @travel, notice: 'Travel was successfully created.' }
        format.json { render :show, status: :created, location: @travel }
      else
        format.html { render :new }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /travels/1
  # PATCH/PUT /travels/1.json
  def update
    respond_to do |format|
      if @travel.update(travel_params)
        # Check file before get
        if params[:travel][:file] != nil
          # Get file attached
          file_upload = params[:travel][:file]
          # Write file to public/files with original file name
          File.open(Rails.root.join('app/assets','images', file_upload.original_filename), "wb") do |file| 
             file.write(file_upload.read)
          end
          # Set name file to create to DB
          @travel.update_attribute(:file, file_upload.original_filename)
        end

        format.html { redirect_to @travel, notice: 'Travel was successfully updated.' }
        format.json { render :show, status: :ok, location: @travel }
      else
        format.html { render :edit }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /travels/1
  # DELETE /travels/1.json
  def destroy
    @travel.destroy
    respond_to do |format|
      format.html { redirect_to travels_url, notice: 'Travel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_travel
      @travel = Travel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def travel_params
      params.require(:travel).permit(:name_tour, :price, :date, :time_go, :details, :file)
    end

    def travel_params_update
      params.require(:travel).permit(:name_tour, :price, :date, :time_go, :details, :file => [:original_filename])
    end
end
