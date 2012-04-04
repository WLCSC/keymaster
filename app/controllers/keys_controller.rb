class KeysController < ApplicationController
  # GET /keys
  # GET /keys.json
  def index
    @keys = Key.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @keys }
    end
  end

  # GET /keys/1
  # GET /keys/1.json
  def show
    @key = Key.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @key }
    end
  end

  # GET /keys/new
  # GET /keys/new.json
  def new
    @key = Key.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @key }
    end
  end

  # POST /keys
  # POST /keys.json
  def create
    @key = Key.new(params[:key])

    respond_to do |format|
      if @key.save
        format.html { redirect_to @key, notice: 'Key was successfully created.' }
        format.json { render json: @key, status: :created, location: @key }
      else
        format.html { render action: "new" }
        format.json { render json: @key.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    
  end

  # DELETE /keys/1
  # DELETE /keys/1.json
  def destroy
    @key = Key.find(params[:id])
    @key.notes.each do |note|
	note.destroy
    end

    @key.keyrings.each do |k|
	k.destroy
    end
    @key.destroy

    respond_to do |format|
      format.html { redirect_to keys_url }
      format.json { head :no_content }
    end
  end

  def add_person
    @key = Key.find(params[:key_id])
    name = params[:name].split(' ')
    @person = Person.find_or_create_by_first_name_and_last_name(name[0], name[1])
    @person.keys << @key
    redirect_to @person
  end

  def remove_person
    @key = Key.find(params[:key_id])
    @person = Person.find(params[:person_id])
    @keyring = Keyring.where(:key_id => @key.id).where(:person_id => @person.id).first.delete
    redirect_to @person
  end
end
