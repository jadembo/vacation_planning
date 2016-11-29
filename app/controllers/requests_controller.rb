class RequestsController < ApplicationController

  #Show All Requests
  def index
    @requests = Request.all

    render("requests/index.html.erb")
  end

  #Show USER'S requests
  def show
    @requests = current_user.requests.order('allotment_id ASC')
    render("requests/show.html.erb")
  end

  #Show day's available for the user's role and department
  def schedule
    @allotments = Allotment.where(:role_id =>current_user.role_id, :department_id => current_user.department_id).order('date ASC')


    @cohort = User.where(:department_id =>current_user.department_id, :role_id => current_user.role_id)
    @cohort_requests_full_days = Request.where(:user_id => @cohort.ids, :length => "full day")
    @cohort_requests_half_days = Request.where(:user_id => @cohort.ids, :length => ["am half day", "pm half day"])

    render("requests/schedule_vacation.html.erb")
  end

  #Schedule vacation day from 'schedule a vacation day' page
  def add_vacation_day
    @request = Request.new

    @request.user_id = current_user.id
    @request.allotment_id = params[:allotment_id]
    @request.length = params[:length].gsub("_"," ").downcase
    @request.request_type = "vacation"
    save_status = @request.save

    if save_status == true
      redirect_to("/schedule_vacation", :notice => "Request updated successfully.")
    end
  end

  #Schedule personal day from 'schedule a vacation day' page
  def add_personal_day
    @request = Request.new

    @request.user_id = current_user.id
    @request.allotment_id = params[:allotment_id]
    @request.length = params[:length].gsub("_"," ").downcase
    @request.request_type = "personal day"
    save_status = @request.save

    if save_status == true
      redirect_to("/schedule_vacation", :notice => "Request updated successfully.")
    end
  end

  def department_vacation
    @department_employees = current_user.department.users
    @department_full_day_vacations = Request.where(:user_id => @department_employees.ids, :length => "full day")
    @department_half_day_vacations = Request.where(:user_id => @department_employees.ids, :length => ["am half day", "pm half day"])

    if params[:month] == nil
      @month_filter = 1
    else
    @month_filter = params[:month].to_i
    end

    if params[:role_id] == nil
      @role_filter = 1
    else
      @role_filter = params[:role_id].to_i
    end

    @allotments = current_user.department.allotments
    
    render ("requests/department_vacation.html.erb")


  end



  def destroy
    @request = Request.find(params[:id])

    @request.destroy

    if URI(request.referer).path == "/requests/#{@request.id}"
      redirect_to("/", :notice => "Request deleted.")
    else
      redirect_to(:back, :notice => "Request deleted.")
    end
  end




end
