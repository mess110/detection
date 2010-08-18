class ApiKeysController < ApplicationController
  # GET /api_keys
  # GET /api_keys.xml
  def index
    if params[:key] && params[:secret]
      @api_keys = ApiKey.find(:all, :conditions => { :key => params[:key],
                                                     :secret => params[:secret]
                                                   })
    elsif params[:user_id]
      @api_keys = ApiKey.find(:all, :conditions => { :user_id => params[:user_id] })
    else
      @api_keys = ApiKey.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @api_keys }
    end
  end

  # GET /api_keys/1
  # GET /api_keys/1.xml
  def show
    @api_key = ApiKey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @api_key }
    end
  end

  # GET /api_keys/new
  # GET /api_keys/new.xml
  def new
    @api_key = ApiKey.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @api_key }
    end
  end

  # GET /api_keys/1/edit
  def edit
    @api_key = ApiKey.find(params[:id])
  end

  # POST /api_keys
  # POST /api_keys.xml
  def create
    @api_key = ApiKey.new(params[:api_key])

    respond_to do |format|
      if @api_key.save
        format.html { redirect_to(@api_key, :notice => 'ApiKey was successfully created.') }
        format.xml  { render :xml => @api_key, :status => :created, :location => @api_key }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @api_key.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /api_keys/1
  # PUT /api_keys/1.xml
  def update
    @api_key = ApiKey.find(params[:id])

    respond_to do |format|
      if @api_key.update_attributes(params[:api_key])
        format.html { redirect_to(@api_key, :notice => 'ApiKey was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @api_key.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /api_keys/1
  # DELETE /api_keys/1.xml
  def destroy
    @api_key = ApiKey.find(params[:id])
    @api_key.destroy

    respond_to do |format|
      format.html { redirect_to(api_keys_url) }
      format.xml  { head :ok }
    end
  end
end
