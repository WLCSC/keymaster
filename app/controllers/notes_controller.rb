class NotesController < ApplicationController
  # POST /people
  # POST /people.json
  def create
    @note = Note.new(params[:note])
    @note.key.notes.each do |n|
	if n != @note && n.content == @note.content
		@note.errors << "Duplicate"
	end
    end

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note.key, notice: 'Note was successfully added.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { redirect_to @note.key, notice: 'Note was not added.' }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @note = Note.find(params[:id])
    @key = @note.key
    @note.destroy

    respond_to do |format|
      format.html { redirect_to @key, notice: 'Note removed.' }
      format.json { head :no_content }
    end
  end

end
