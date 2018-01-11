class RegisteredApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :identify_user, except: %i[index new create]

  def index
    @registered_applications = RegisteredApplication.where('user_id = ?', current_user.id)
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
    @events = @registered_application.events.group_by(&:name)
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def create
    @registered_application = RegisteredApplication.new(registered_application_params)
    @registered_application.user_id = current_user.id

    if @registered_application.save
      redirect_to @registered_application, notice: 'Application has been registered.'
    else
      flash.now[:alert] = 'Error during registration. Please try again.'
      render :new
    end
  end

  def edit
    @registered_application = RegisteredApplication.find(params[:id])
  end

  def update
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.update_attributes(registered_application_params)
      flash[:notice] = 'Registration has been updated.'
      redirect_to @registered_application
    else
      flash.now[:alert] = 'Error saving new information. Please try again.'
      render :edit
    end
  end

  def destroy
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.destroy
      flash[:notice] = "\"#{@registered_application.name}\" was deleted successfully."
      redirect_to registered_applications_path
    else
      flash.now[:alert] = 'There was an error deleting this registration.'
      render :show
    end
  end

  private

  def registered_application_params
    params.require(:registered_application).permit(%i[name url user_id])
  end

  def identify_user
    app = RegisteredApplication.find(params[:id])
    unless current_user == app.user
      flash[:alert] = 'This is not one of your applications.'
      redirect_to action: :index
    end
 end
end
