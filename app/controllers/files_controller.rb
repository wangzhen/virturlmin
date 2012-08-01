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
      @path = "/home/wangzhen/#{@file}"
      @path.to_s.gsub!('\.\.' , '')
      if File.directory?(@path)
       @files =  Dir.foreach("/home/wangzhen/#{@file}") 
      else
       send_file         @path
      end
    else
      @path = "/home/wangzhen"
      @files =  Dir.foreach("/home/wangzhen")
    
    end


   
  end


def zip

    if params[:file]
      @file =  params[:file] 
      @path = "/home/wangzhen/#{@file}"
    else
      @path = "/home/wangzhen"
    end
     @path.to_s.gsub!('\.\.' , '')
     p system(" tar czf #{@path}.tar.gz  #{@path}  ")
     # p system(" chown -R wangzhen:wangzhen   /home/wangzhen/")
     redirect_to "#{files_path}/master/#{@file}/.."
end


def unzip


    if params[:file]
      @file =  params[:file] 
      @path = "/home/wangzhen/#{@file}"
    else
      @path = "/home/wangzhen"
    end
    if params[:f]
      @d =  params[:f] 
      @directory = "/home/wangzhen/#{@d}"
    else
      @directory = "/home/wangzhen"
    end


     @path.to_s.gsub!('\.\.' , '')
     @directory.to_s.gsub!('\.\.' , '')

     if @path.include?(".tar")
     p system("  tar xvf #{@path}  -C  #{@directory}  ")
     end
    if @path.include?(".zip")
     p system(" unzip #{@path}  -d  #{@directory}  ")
     end
     # p system(" chown -R wangzhen:wangzhen   /home/wangzhen/")
     redirect_to "#{files_path}/master/#{@file}/.."
  
end


def create

        @path = "/home/wangzhen/#{params[:file]}"
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
 

      @path = "/home/wangzhen/#{params[:file]}"
      @files =  Dir.foreach("/home/wangzhen/#{params[:file]}") 

        render :index
   
  end
end
