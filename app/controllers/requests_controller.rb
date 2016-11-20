class RequestsController < ApplicationController
  def index
    @requests = Request.all

    render("requests/index.html.erb")
  end

  def show
    @request = Request.find(params[:id])

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
    @request.length = params[:length]
    @request.type = params[:type]

    save_status = @request.save

    if save_status == true
      redirect_to("/requests/#{@request.id}", :notice => "Request created successfully.")
    else
      render("requests/new.html.erb")
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
    @request.length = params[:length]
    @request.type = params[:type]

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
end
