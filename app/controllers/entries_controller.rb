class EntriesController < ApplicationController
  load_and_authorize_resource
  before_action :set_entry, only: %i[ show edit update destroy ]

  # GET /entries or /entries.json
  def index
    if params[:category_id].present?
      category = Category.find(params[:category_id])
      @entries = category.entries.includes(:categories).order(created_at: :desc).where(user_id: current_user.id)
      @total_amount = @entries.sum(:amount)
    else
      @entries = Entry.all.includes(:categories).order(created_at: :desc).where(user_id: current_user.id)
    end
  end

  # GET /entries/1 or /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
    @entry.categories << Category.find(params[:category_id]) if params[:category_id].present?
    @categories = Category.all.order(created_at: :desc).where(user_id: current_user.id)
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries or /entries.json
  def create
    @entry = Entry.new(entry_params)
    @entry.user = current_user
    @categories = Category.all.order(created_at: :desc).where(user_id: current_user.id) unless @entry.save
    respond_to do |format|
      if @entry.save
        if params[:category_id].present?
          format.html { redirect_to category_entries_url(params[:category_id]), notice: "Entry was successfully created." }
        else
          format.html { redirect_to entry_url(@entry), notice: "Entry was successfully created." }
        end
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @entry.destroy!

    respond_to do |format|
      format.html { redirect_to entries_url, notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entry_params
      params.require(:entry).permit(:name, :amount, category_ids: [])
    end
end
