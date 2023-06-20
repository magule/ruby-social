class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /notes or /notes.json
  def index
    @notes = Note.all
  end

def feed
  @users = User.all

  @notes = current_user.following.map(&:notes).flatten
end




  # GET /notes/1 or /notes/1.json
  def show
    @following_users = current_user.following # Retrieve the users you follow

    if @note.shared_notes.exists?(user: current_user)
      @shared_note = @note.shared_notes.find_by(user: current_user)
    else
      @shared_note = SharedNote.new(user: current_user, note: @note)
    end
  end

  # GET /notes/new
  def new
    @note = current_user.notes.build
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = current_user.notes.build(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to note_url(@note), notice: "Note was successfully created." }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to note_url(@note), notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @note = current_user.notes.find_by(id: params[:id])
    redirect_to notes_path, notice: "You can't do that." if @note.nil?
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content, :username, :user_id, :picture, :collection_id)
  end




  # notes_controller.rb

  def select_friend
      

      @note = Note.find(params[:note_id])
    @users = current_user.followers.all

     # Render the select_friend.html.erb view
   end

   def share_with_friend
     friend_id = params[:friend_id]
     note_id = params[:note_id]

     # Perform any necessary logic to share the note with the friend
     if current_user.follower_with?(friend_id)
       # Share the note with the friend
       note = Note.find(note_id)
       note.share_with_friend(friend_id)

       # Redirect or render a response
       redirect_to note_path(note), notice: 'Note shared with friend successfully.'
     else
       # Handle the case where the friend is not valid or not in the user's follower list
       redirect_to notes_path, alert: 'Invalid friend selection.'
     end
   end




end
