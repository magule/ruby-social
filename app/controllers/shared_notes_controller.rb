# app/controllers/shared_notes_controller.rb

class SharedNotesController < ApplicationController
  before_action :authenticate_user!

  def create
    note = Note.find(params[:shared_note][:note_id])
    shared_note = SharedNote.new(user: current_user, note: note)

    if shared_note.save
      redirect_to note_path(note), notice: "Note shared successfully!"
    else
      redirect_to note_path(note), alert: "Failed to share note."
    end
  end
end
