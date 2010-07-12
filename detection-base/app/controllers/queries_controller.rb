class QueriesController < ApplicationController
  # GET /queries
  # GET /queries.xml
  def index
    @queries = Query.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @queries }
    end
  end

  # GET /queries/1
  # GET /queries/1.xml
  def show
    @query = Query.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @query }
    end
  end

  # GET /queries/new
  # GET /queries/new.xml
  def new
    @query = Query.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @query }
    end
  end

  # GET /queries/1/edit
  def edit
    @query = Query.find(params[:id])
  end

  # POST /queries
  # POST /queries.xml
  def create
    @query = Query.new(params[:query])

    respond_to do |format|
      if @query.save
        format.html { redirect_to(@query, :notice => 'Query was successfully created.') }
        format.xml  { render :xml => @query, :status => :created, :location => @query }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @query.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /queries/1
  # PUT /queries/1.xml
  def update
    @query = Query.find(params[:id])

    respond_to do |format|
      if @query.update_attributes(params[:query])
        format.html { redirect_to(@query, :notice => 'Query was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @query.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /queries/1
  # DELETE /queries/1.xml
  def destroy
    @query = Query.find(params[:id])
    @query.destroy

    respond_to do |format|
      format.html { redirect_to(queries_url) }
      format.xml  { head :ok }
    end
  end
end
