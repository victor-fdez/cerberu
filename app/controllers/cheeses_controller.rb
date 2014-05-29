
class CheesesController < ApplicationController
  before_action :set_cheese, only: [:show, :edit, :update, :destroy]

  # GET /cheeses
  # GET /cheeses.json
  def index
		if search_cheese_params.has_key?(:search)
			search = search_cheese_params[:search]
			@cheeses = Cheese.where("name like ?", "%#{search}%")
		else
			@cheeses = Cheese.all
		end
  end

  # GET /cheeses/1
  # GET /cheeses/1.json
  def show
  end

	# GET /cheeses/search
	def search
		search = search_cheese_params[:search]
		@cheeses = Cheese.where("name like ?", "%#{search}%")
=begin
		@search = Cheese.search do
				fulltext "ch" do
					fields(:name)
				end
			end
		p @search.total
		@cheeses = @search.results
=end
		respond_to do |format|
			format.json { render json: @cheeses }
			format.html { render "index" }
		end
	end

  # GET /cheeses/new
  def new
    @cheese = Cheese.new
		1.times do
			record = @cheese.process_records.build
			record.build_process_type
			record.time_measures.build
		end
  end

  # GET /cheeses/1/edit
  def edit
		#p self.instance_variables
		#p local_variables
  end

  # POST /cheeses
  # POST /cheeses.json
  def create
    @cheese = Cheese.new(cheese_params)
		if @cheese.valid?
			respond_to do |format|
				if @cheese.save
					format.html { redirect_to @cheese, notice: 'Cheese was successfully created.' }
					format.json { render :show, status: :created, location: @cheese }
				else
					format.html { render :new }
					format.json { render json: @cheese.errors, status: :unprocessable_entity }
				end
			end
		else
			render :new
		end
  end

  # PATCH/PUT /cheeses/1
  # PATCH/PUT /cheeses/1.json
  def update
    respond_to do |format|
      if @cheese.update(cheese_params)
        format.html { redirect_to @cheese, notice: 'Cheese was successfully updated.' }
        format.json { render :show, status: :ok, location: @cheese }
      else
        format.html { render :edit }
        format.json { render json: @cheese.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cheeses/1
  # DELETE /cheeses/1.json
  def destroy
    @cheese.destroy
    respond_to do |format|
      format.html { redirect_to cheeses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cheese
      @cheese = Cheese.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cheese_params
      params.require(:cheese).permit(:id, 
																		 :about, 
																		 :name,
																		 :process_records_attributes => [ 
																		 		:id, 
																				:notes, 
																				:cheese_id, 
																				:_destroy,
																				:process_type_attributes => [:id, :name], 
																				:time_measures_attributes => [:id, :time, :temp, :ph, :_destroy]
																		]
																		)
    end

		def search_cheese_params
			params.permit(:search)
		end
end
