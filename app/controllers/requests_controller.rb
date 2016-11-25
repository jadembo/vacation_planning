class RequestsController < ApplicationController
  def index
    @requests = Request.all

    render("requests/index.html.erb")
  end

  def show
    @requests = Request.where(:user_id => current_user.id)

    render("requests/show.html.erb")
  end

  def new
    @request = Request.new

    render("requests/new.html.erb")
  end

  def create
    @request = Request.new

    @request.user_id = params[:user_id]
    @request.allotment_id = params[:allotment_id]
    @request.length = params[:length].downcase
    @request.request_type = params[:request_type].downcase

    save_status = @request.save

    if save_status == true
      redirect_to("/my_requests", :notice => "Request created successfully.")
    else
      render("requests/new.html.erb")
    end
  end

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

  def edit
    @request = Request.find(params[:id])

    render("requests/edit.html.erb")
  end

  def update
    @request = Request.find(params[:id])

    @request.user_id = params[:user_id]
    @request.allotment_id = params[:allotment_id]
    @request.length = params[:length].downcase
    @request.request_type = params[:request_type].downcase

    save_status = @request.save

    if save_status == true
      redirect_to("/requests/#{@request.id}", :notice => "Request updated successfully.")
    else
      render("requests/edit.html.erb")
    end
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

  def schedule
    @allotments_step_1 = Allotment.where(:department_id => current_user.department_id)
    @allotments_for_user = @allotments_step_1.where(:role_id => current_user.role_id)


    @cohort = User.where(:department_id =>current_user.department_id, :role_id => current_user.role_id)
    @cohort_requests_full_days = Request.where(:user_id => @cohort.ids, :length => "full day")
    @cohort_requests_half_days = Request.where(:user_id => @cohort.ids, :length => ["am half day", "pm half day"])


    render("requests/schedule_vacation.html.erb")
  end



end
