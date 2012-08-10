# coding: UTF-8
class FilesController < ApplicationController
  before_filter :user_authorize
  layout 'users'
  # GE: /blogs
  # GET /blogs.xml
  def index
 
 

    if params[:file]
      @file =  params[:file] 
      p @file
      @path = "/home/session[:user_name]/#{@file}"
      @path.to_s.gsub!('\.\.' , '')
      if File.directory?(@path)
       @files =  Dir.foreach("/home/session[:user_name]/#{@file}") 
      else
       send_file         @path
      end
    else
      @path = "/home/session[:user_name]"
      @files =  Dir.foreach("/home/session[:user_name]")
    
    end


   
  end


def zip

    if params[:file]
      @file =  params[:file] 
      @path = "/home/session[:user_name]/#{@file}"
    else
      @path = "/home/session[:user_name]"
    end
     @path.to_s.gsub!('\.\.' , '')
     p system(" tar czf #{@path}.tar.gz  #{@path}  ")
     # p system(" chown -R session[:user_name]:session[:user_name]   /home/session[:user_name]/")
     redirect_to "#{files_path}/master/#{@file}/.."
end


def unzip


    if params[:file]
      @file =  params[:file] 
      @path = "/home/session[:user_name]/#{@file}"
    else
      @path = "/home/session[:user_name]"
    end
    if params[:f]
      @d =  params[:f] 
      @directory = "/home/session[:user_name]/#{@d}"
    else
      @directory = "/home/session[:user_name]"
    end


     @path.to_s.gsub!('\.\.' , '')
     @directory.to_s.gsub!('\.\.' , '')

     if @path.include?(".tar")
     p system("  tar xvf #{@path}  -C  #{@directory}  ")
     end
    if @path.include?(".zip")
     p system(" unzip #{@path}  -d  #{@directory}  ")
     end
     # p system(" chown -R session[:user_name]:session[:user_name]   /home/session[:user_name]/")
     redirect_to "#{files_path}/master/#{@file}/.."
  
end


def create

        @path = "/home/session[:user_name]/#{params[:file]}"
        @path.to_s.gsub!('\.\.' , '')
        @path.to_s.gsub!(/\/\// , '/')
      # ic = Iconv.new('GBK//IGNORE', 'UTF-8')
    # user =   File.open("#{RAILS_ROOT}/#{file}.xls" ,'w+')
    # user.write(params[:file].read)
    # user.close
# f = File.open("#{@path}/#{params[:filedata].original_filename}", "w+")
 # f.write(Iconv.iconv(  'gbk','utf-8',   params[:filedata].read) ) 
 unless  params[:filedata].blank?
f = File.open("#{@path}/#{params[:filedata].original_filename}", "wb")
f.write( params[:filedata].read) 
f.close
end

 redirect_to "#{files_path}/#{params[:file]}"

end


  def show
 

      @path = "/home/session[:user_name]/#{params[:file]}"
      @files =  Dir.foreach("/home/session[:user_name]/#{params[:file]}") 

        render :index
   
  end
end
