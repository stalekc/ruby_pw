class ForumsController < ApplicationController
  before_action :set_forum, only: [:show, :edit, :update, :destroy]

  # GET /forums
  # GET /forums.json
  def index
    @forums = Forum.all
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
    if params[:mes]
      if params[:mes].length > 0
      ans = Message.create(:text => params[:mes], :forum_id => @forum.id, :user_id => current_user.id)
      ans.save
      @str = 1
      redirect_to forum_path
      end
    else
      if params[:str]
        @str = params[:str].to_i
      else
        @str = 1
      end
    end
    @answer = Message.find_by_sql("select * from messages where forum_id = " + @forum.id.to_s + " order by id")
  end

  # GET /forums/new
  def new
    @forum = Forum.new
  end

  # GET /forums/1/edit
  def edit
  end

  # POST /forums
  # POST /forums.json
  def create
    if forum_params[:name].length != 0
      @forum = Forum.new(forum_params)
    else
      @problem = 1
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @problem, status: :unprocessable_entity }
      end
    end
    if @forum
      respond_to do |format|
        if @forum.save
          format.html { redirect_to @forum, notice: 'Forum was successfully created.' }
          format.json { render :show, status: :created, location: @forum }
        else
          format.html { render :new }
          format.json { render json: @forum.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /forums/1
  # PATCH/PUT /forums/1.json
  def update
    respond_to do |format|
      if @forum.update(forum_params)
        format.html { redirect_to @forum, notice: 'Forum was successfully updated.' }
        format.json { render :show, status: :ok, location: @forum }
      else
        format.html { render :edit }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
    @forum.destroy
    respond_to do |format|
      format.html { redirect_to forums_url, notice: 'Forum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forum
      @forum = Forum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forum_params
      params.require(:forum).permit(:name)
    end
end
