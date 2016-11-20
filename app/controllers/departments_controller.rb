class DepartmentsController < ApplicationController
  def index
    @departments = Department.all

    render("departments/index.html.erb")
  end

  def show
    @department = Department.find(params[:id])

    render("departments/show.html.erb")
  end

  def new
    @department = Department.new

    render("departments/new.html.erb")
  end

  def create
    @department = Department.new

    @department.department_name = params[:department_name]

    save_status = @department.save

    if save_status == true
      redirect_to("/departments/#{@department.id}", :notice => "Department created successfully.")
    else
      render("departments/new.html.erb")
    end
  end

  def edit
    @department = Department.find(params[:id])

    render("departments/edit.html.erb")
  end

  def update
    @department = Department.find(params[:id])

    @department.department_name = params[:department_name]

    save_status = @department.save

    if save_status == true
      redirect_to("/departments/#{@department.id}", :notice => "Department updated successfully.")
    else
      render("departments/edit.html.erb")
    end
  end

  def destroy
    @department = Department.find(params[:id])

    @department.destroy

    if URI(request.referer).path == "/departments/#{@department.id}"
      redirect_to("/", :notice => "Department deleted.")
    else
      redirect_to(:back, :notice => "Department deleted.")
    end
  end
end
