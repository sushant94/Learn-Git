include RepoHelper
include TeamHelper
class CourseController < ApplicationController
  before_filter :authenticate_user!

  def index
    @courses = Course.all
  end

  def show
    #TODO: Check if the course is requires team or not, depending on that checking he has a team or not
    flag=0
    @course = Course.find(params[:id])
    current_user.repos.each do |repository|
      if repository.course_id == @course.id
	flag=1
      end
    end
    #This is to check if he is registered for the course or not
    if flag == 0
      redirect_to root_path
    else
      repos = current_user.repos
      @all_repos = Repo.where(team_id: repos.find_by_course_id(@course.id).team.id)
      unless repos.nil?
	@stage = @course.stages.find_by_step_number(repos.first.status)
      else
	@stage = @course.stages.first
      end
    end
  end

  def join
    @course = Course.find(params[:id])
    #Check if course is of team or not
    if @course.mcount > 1
      #Handle Team registration
      redirect_to "/team/new/#{@course.id}"
    else
      create_team(@course.id)
      puts "redddirectinggg"*20
      redirect_to "/course/#{@course.id}"
    end
  end


end
