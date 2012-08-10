# coding: UTF-8
class UsersController < ApplicationController
  # GE: /Users
  # GET /Users.xml
   before_filter :user_authorize
   skip_before_filter :user_authorize, :only => [:new, :create]

  def index
    @user = User.find_by_name(  session[:user_name] )
 
  end

  # # GET /Users/1
  # # GET /Users/1.xml
  # def show
  #   @user = User.find(params[:id])
 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @user }
  #   end
  # end

  # GET /Users/new
  # GET /Users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /Users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /Users
  # POST /Users.xml
  def create
    @user = User.new(params[:user])

    # render :update do |page|
    #   if @user.save
    #     page.alert('sucess create')
    #   else
    #     page.alert(@user.errors.full_messages.join("\n"))
    #   end
    # end

       respond_to do |format|
         if @user.save
          session[:user_name] =  @user.name
# create user
p system("useradd -m #{@user.name} -s /bin/bash  ")
p system("passwd #{@user.name} <<EOF
#{@user.password}
#{@user.password}
EOF")
# create mysql
p system(
" mysql -uroot -p123456 -e\"
CREATE USER '#{@user.name}'@'%' IDENTIFIED BY  '#{@user.password}';
GRANT USAGE ON * . * TO  '#{@user.name}'@'%' IDENTIFIED BY  '#{@user.name}' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
CREATE DATABASE IF NOT EXISTS  #{@user.name} ;
GRANT ALL PRIVILEGES ON  #{@user.name}.* TO  '#{@user.name}'@'%'  IDENTIFIED BY  '#{@user.password}';
\"
")

# # create nginx
File.open("/opt/nginx/conf/website/#{@user.name}.conf", "w") do |file|
file.write(
   " server {
        listen       80;
        server_name   #{@user.domain} #{@user.domain2};

      location / {
        root   /home/#{@user.name}/www;

        access_log /root/#{@user.name}.log;
        error_log  /root/#{@user.name}.log;

        index  index.php index.html index.htm;
        }

       location ~ \.php$ {
            root   /home/#{@user.name}/www;
            index  index.php index.html index.htm;
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILEnAME  /scripts$fastcgi_script_name;
            fastcgi_param  SCRIPT_FILENAME  /home/#{@user.name}/www$fastcgi_script_name;
            fastcgi_param SCRIPT_NAME /home/#{@user.name}/www$fastcgi_script_name;
            include        fastcgi_params;
       }

    }
    "
)
end

           format.html { redirect_to(@user, :notice => 'User was successfully created.') }
           format.xml  { render :xml => @user, :status => :created, :location => @user }
         else
           format.html { render :action => "new" }
           format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
         end
       end
  end

  # PUT /Users/1
  # PUT /Users/1.xml
  def update
        @user = User.find_by_name(session[:user_name])
        params[:user].delete('name')
        params[:user].delete('domain')
 
   respond_to do |format|
     if @user.update_attributes(params[:user])
       format.html { redirect_to(users_path, :notice => '保存成功') }
       format.xml  { head :ok }
     else
       format.html { render :action => "edit" ,:notice => '保存11111'  }
       format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
     end
   end
  end


  def password
        @user = User.find_by_name(session[:user_name])

  if request.put?
   params[:user].delete('name')
   params[:user].delete('domain')
   respond_to do |format|
     if @user.update_attributes(params[:user])

      p system("passwd #{@user.name} <<EOF
#{@user.password}
#{@user.password}
EOF")
      flash[:notice] = '修改成功!'
       format.html { redirect_to(users_path) }
       format.xml  { head :ok }
     else
       flash[:notice] = '修改失败!'
       format.html { redirect_to(users_path) }
       format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
     end
   end
 end

  end

  def domain
        @user = User.find_by_name(session[:user_name])
 
 if request.put?
params[:user].delete('name')
# params[:domain].delete('domain')

File.open("/opt/nginx/conf/website/#{@user.name}.conf", "w") do |file|
file.write(
   " server {
        listen       80;
        server_name   #{@user.domain} #{@user.domain2};

      location / {
        root   /home/#{@user.name}/www;

        access_log /root/#{@user.name}.log;
        error_log  /root/#{@user.name}.log;

        index  index.php index.html index.htm;
        }

       location ~ \.php$ {
            root   /home/#{@user.name}/www;
            index  index.php index.html index.htm;
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILEnAME  /scripts$fastcgi_script_name;
            fastcgi_param  SCRIPT_FILENAME  /home/#{@user.name}/www$fastcgi_script_name;
            fastcgi_param SCRIPT_NAME /home/#{@user.name}/www$fastcgi_script_name;
            include        fastcgi_params;
       }

    }
    ")
  end



   respond_to do |format|
     if @user.update_attributes(params[:user])
       format.html { redirect_to(users_path, :notice => '修改成功!') }
       format.xml  { head :ok }
     else
       format.html { render :action => "edit" }
       format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
     end
   end
 end


  end

  # def show
    
  # end

 
end
