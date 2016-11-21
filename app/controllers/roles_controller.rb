class RolesController < ApplicationController
  def index
    @roles = Role.all

    render("roles/index.html.erb")
  end

  def show
    @role = Role.find(params[:id])

    render("roles/show.html.erb")
  end

  def new
    @role = Role.new

    render("roles/new.html.erb")
  end

  def create
    @role = Role.new

    @role.role_name = params[:role_name]


    save_status = @role.save

    if save_status == true
      redirect_to("/roles/#{@role.id}", :notice => "Role created successfully.")
    else
      render("roles/new.html.erb")
    end
  end

  def edit
    @role = Role.find(params[:id])

    render("roles/edit.html.erb")
  end

  def update
    @role = Role.find(params[:id])

    @role.role_name = params[:role_name]
  

    save_status = @role.save

    if save_status == true
      redirect_to("/roles/#{@role.id}", :notice => "Role updated successfully.")
    else
      render("roles/edit.html.erb")
    end
  end

  def destroy
    @role = Role.find(params[:id])

    @role.destroy

    if URI(request.referer).path == "/roles/#{@role.id}"
      redirect_to("/", :notice => "Role deleted.")
    else
      redirect_to(:back, :notice => "Role deleted.")
    end
  end
end
