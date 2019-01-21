class JobsController < ApplicationController
  
  def add
    @job = Job.new
    @job.name = params[:name]
    puts @job.name
    if @job.save
      render :json => id=1
    else
      render :json => id=0    
     end  
  end

end
