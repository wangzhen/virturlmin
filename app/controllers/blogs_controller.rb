class BlogsController < ApplicationController
  # GE: /blogs
  # GET /blogs.xml
  def index
    @search = Blog.search(params[:search])
    @search.category_id_equals = params[:category_id] unless params[:category_id].blank?
    @blogs = @search.page( params[:page]).per(10 ||params[:per_page])
    @title = 'Anthony Blog | Ruby on Rails | ROR | ror | rails | ruby'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blogs }
    end
  end

  # GET /blogs/1
  # GET /blogs/1.xml
  def show
    @blog = Blog.find(params[:id])
    @title = "#{@blog.title} | Anthony Blog | Ruby on Rails | ROR"
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @blog }
    end
  end

  # GET /blogs/new
  # GET /blogs/new.xml
  def new
    @blog = Blog.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blog }
    end
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
  end

  # POST /blogs
  # POST /blogs.xml
  def create
    @blog = Blog.new(params[:blog])

    render :update do |page|
      if @blog.save
        page.alert('sucess create')
      else
        page.alert(@blog.errors.full_messages.join("\n"))
      end
    end

    #    respond_to do |format|
    #      if @blog.save
    #        format.html { redirect_to(@blog, :notice => 'Blog was successfully created.') }
    #        format.xml  { render :xml => @blog, :status => :created, :location => @blog }
    #      else
    #        format.html { render :action => "new" }
    #        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
    #      end
    #    end
  end

  # PUT /blogs/1
  # PUT /blogs/1.xml
  def update
    @blog = Blog.find(params[:id])


        render :update do |page|
      if @blog.update_attributes(params[:blog])
        page.alert('sucess update')
      else
        page.alert(@blog.errors.full_messages.join("\n"))
      end
    end

#    respond_to do |format|
#      if @blog.update_attributes(params[:blog])
#        format.html { redirect_to(@blog, :notice => 'Blog was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @blog.errors, :status => :unprocessable_entity }
#      end
#    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.xml
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to(blogs_url) }
      format.xml  { head :ok }
    end
  end
end
