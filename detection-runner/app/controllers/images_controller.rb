class ImagesController < ApplicationController

  #def new
  #  img = Image.create(:url => params[:url])
  #  if img.errors.count > 0
  #    render_error
  #  end
  #  respond_to do |format|
  #    format.xml { render :xml => img}
  #    format.html { render :xml => img}
  #  end
  #end

  # GET /xxxxxxes
  # GET /xxxxxxes.xml
  def index
    @images = Image.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images.to_xml( :include => :regions ) }
    end
  end

  # GET /xxxxxxes/1
  # GET /xxxxxxes/1.xml
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image.to_xml( :include => :regions ) }
    end
  end

  # GET /xxxxxxes/new
  # GET /xxxxxxes/new.xml
  def new
    @image = Images.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /xxxxxxes/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /xxxxxxes
  # POST /xxxxxxes.xml
  def create
    @image = Image.new(params[:xxxxxx])

    respond_to do |format|
      if @image.save
        format.html { redirect_to(@image, :notice => 'Image was successfully created.') }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /xxxxxxes/1
  # PUT /xxxxxxes/1.xml
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to(@image, :notice => 'Image was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /xxxxxxes/1
  # DELETE /xxxxxxes/1.xml
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(images_url) }
      format.xml  { head :ok }
    end
  end
end
