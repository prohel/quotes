class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  # GET /quotes
  # GET /quotes.json
  def index
    p = PennExtranetAdapter.new('prohel', 'StHuStFo1437')
    o = p.authenticated_agent
    p o.inspect
    @quotes = Quote.all
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)
    respond_to do |format|
      if @quote.save
        @quotes = Quote.all
        format.html { redirect_to @quote, notice: 'Quote was successfully created.' }
        format.js {render "create", :locals => {:error => 0, :quotes => @quotes}}
        format.json { render json: @quote }
      else
        format.html { render :new }
        format.js {render "create", :locals => {:error => 1}}
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
     @quotes = Quote.where("text LIKE ? OR author LIKE ? ",
     "%#{params[:search]}%", "%#{params[:search]}%")
     render :template => "quotes/index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:author, :text)
    end
end
