class TopsController < ApplicationController
  # GET /blogs
  # GET /blogs.xml
  def index
    @user = User.new
 # ActiveRecord::Base.connection.execute
# p system(
# " mysql -uroot -p123456 -e\"
# create dabatase
# CREATE USER 'cccccc'@'%' IDENTIFIED BY  'cccccc';
# GRANT USAGE ON * . * TO  'cccccc'@'%' IDENTIFIED BY  'cccccc' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
# CREATE DATABASE IF NOT EXISTS  cccccc ;
# GRANT ALL PRIVILEGES ON  cccccc.* TO  'cccccc'@'%'  IDENTIFIED BY  'cccccc';

# \"
# ")

# create _
# CREATE USER 'jjjjjjj'@'%' IDENTIFIED BY  'jjjjjjj';
# GRANT USAGE ON * . * TO  'jjjjjjj'@'%' IDENTIFIED BY  'jjjjjjj' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
# GRANT ALL PRIVILEGES ON  `jjjjjjj\_%` . * TO  'jjjjjjj'@'%';





# GRANT USAGE ON * . * TO  'wangzhen'@'%' IDENTIFIED BY  'wangzhen' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;

#        p system("passwd #{@user.name} <<EOF
# #{@user.password}
# #{@user.password}
# EOF")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blogs }
    end
  end

def ddd
  
end

  # POST /blogs
  # POST /blogs.xml
  def create
 
     unless Link.count > 10
     Link.create({:url => params[:url] , :name => params[:name]  })
     end
     
    redirect_to :action => "index"
  end



end
