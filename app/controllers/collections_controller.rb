class CollectionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  #before_action :correct_user, only: [:destroy]


  def index
   @collections = Collection.all

 end

 def show
   @collection = Collection.find(params[:id])
   @notes = @collection.notes
   
 end
#def show
#  @collection = current_user.collections.find(params[:id])
#  @notes = @collection.notes.where(user_id: current_user.id)
#end


  def new
    #@collection = Collection.new
    @collection = current_user.collections.build
  end



  def create
    #@collection = Collection.new(collection_params)
    @collection = current_user.collections.build(collection_params)

    if @collection.save
      redirect_to collections_url, notice: "Collection was successfully created."
    else
      render :new
    end
  end

  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy
    redirect_to collections_path, notice: "Collection was successfully deleted."
  end


  def correct_user
      @collection = current_user.collection.find_by(id: params[:id])
      redirect_to collection_path, notice: "u cant do that.." if @collection.nil?

  end

  private

  def collection_params
    params.require(:collection).permit(:name, :user_id)
  end
end
