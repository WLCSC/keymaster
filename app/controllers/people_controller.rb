class PeopleController < ApplicationController
	skip_before_filter :authentication_check, :only => [:create, :new]
  # GET /people
  # GET /people.json
  def index
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/new
  # GET /people/new.json
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(params[:person])
    

    respond_to do |format|
      if @person.save
	      @person.keys.each do |k|
	kset = Key.where(:code => k.code)
	if kset.count > 1
		master = kset.delete_at(0)
		kset.each do |s|
			s.notes.each do |n|
				if n.content = ""
					n.delete
				end
				begin
					n.key = master unless (master.notes.where(:content => n.content).count > 0)
					n.save
				rescue e
				end
			end
			s.people.each do |p|
				master.people << p
			end
			s.delete
		end
	end
    end
	format.html {redirect_to new_person_path, :notice => "Thank you!"}
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.json
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person = Person.find(params[:id])
    @person.keyrings.each do |k|
	k.destroy
    end
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end

  def add_key
    @person = Person.find(params[:person_id])
    @key = Key.find_or_create_by_code(params[:key_code])
    @person.keys << @key
    redirect_to @key
  end

  def remove_key
    @person = Person.find(params[:person_id])
    @key = Key.find(params[:key_id])
    @keyring = Keyring.where(:key_id => @key.id).where(:person_id => @person.id).first.delete 
    redirect_to @key
  end
end
