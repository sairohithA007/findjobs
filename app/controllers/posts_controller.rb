require 'json'
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:edit, :update, :destroy]
  
  def index
    posts = Post.where(user_id: current_user.id)
     @posts = posts.paginate(:page => params[:page], :per_page => 4)
     @response_count = Array.new
     @posts.each do |post|
       #postsData = posts_responseToPost_path(self)
       #puts "Hello Post Data: #{postsData}"
       #val = (postsData.data).count
       #@response_count.push(val)
       
     applications = Application.where(post_id: post.id)
     usersData = User.new
     array = Array.new
     applications.each do |application|
      puts application.user_id
      usersData = User.find(application.user_id)
      puts usersData.name
      puts application.user.image_url
      hash = Hash.new
      hash["user"] = usersData
      hash["postId"] = post.id
      array.push(hash)
    end
     @response_count.push(array.length)
       
       
     end
  end
  
  def homepage
    posts = Post.where.not(user_id: current_user.id)
    @posts = posts.paginate(:page => params[:page], :per_page => 4).order(created_at: :desc)
    applications = Application.where(user_id: current_user.id)
    @postids = []
    applications.each do |application|
      @postids << application.post_id
    end 
    @jobs = Job.all   
    @categories = Category.all
  end

  def jobs_category
    puts params[:job]
    data = Array.new
    job = Job.where(id: params[:job])
    category = Category.where(id: params[:category])
    posts = Post.where(job_id: job, category_id: category).order(created_at: :desc)
    postids = []
    applications = Application.where(user_id: current_user.id)
    applications.each do |application|
      postids << application.post_id
    end 
    posts.each do |post|
      hash = Hash.new
      hash["category"] =post.category.name 
      hash["jobName"]= post.job.name
      hash["username"]=post.user.name
      hash["image"]=post.user.image_url
      hash["userid"] = post.user_id
      time = time_diff(post.created_at)
      hash[:created_time]=time
      hash[:content] = post
      if postids.include?(post.id)
        hash[:flag]=0
      else
        hash[:flag]=1
      end
      data.push(hash)
    end
    render :json => data
  end


  def apply
    @application = Application.new
    puts params[:id]
    @application.post_id = params[:id]
    @application.user_id = current_user.id
    if @application.save
      flash[:notice] = "You have applied for this successfully" 
      redirect_to posts_homepage_path
    end
  end
  
  def cancelled
    puts "hello"
    application = Application.find_by(post_id: params[:id], user_id: current_user.id)
    puts application.id
    if application.destroy
      flash[:notice] = "You have cancelled successfully" 
      redirect_to posts_homepage_path
    end
  end
  
  def responseToPost
   responses
  end

  def user
    @user = User.find(params[:id])
    render :json => data= @user.to_json
  end

  def new
    @post = Post.new
    @categories =  Category.all
    @jobs = Job.all
  end
  
  def create
    puts params[:description]
    @post = Post.new(posts_params)
    if @post.user_id == nil
      @post.user_id = current_user.id
    end
    @post.save
    redirect_to posts_path
  end

  def edit
    @categories =  Category.all
    @jobs = Job.all
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path
  end
  
  
  def update
    @post.update(posts_params)  
    redirect_to posts_path  
  end

  private
  def find_post
    @post = Post.find(params[:id])
  end
  
  def posts_params
    params.require(:post).permit(:description, :category_id, :job_id)
  end
  
  def time_diff(end_time)
   time = Time.now.minus_with_coercion(end_time)
            if (((time/3600)/24).round >=1 )
              "#{((time/3600)/24).round} days ago"  
            elsif ((time/3600).round < 24 ) && ((time/60).round > 60 ) 
              "#{((time/3600)).round} hours ago" 
             elsif ((time/60).round < 60 ) 
              "#{(time/60).round} minutes ago" 
              end 
  end
  
  def responses
     applications = Application.where(post_id: params[:id])
     usersData = User.new
     array = Array.new
     applications.each do |application|
      puts application.user_id
      usersData = User.find(application.user_id)
      puts usersData.name
      puts application.user.image_url
      hash = Hash.new
      hash["user"] = usersData
      hash["postId"] = params[:id]
      array.push(hash)
    end
     data= array.to_json
    render :json => data
  end
  
end
