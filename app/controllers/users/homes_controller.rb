class Users::HomesController < ApplicationController
  before_action :authenticate_user!

  def index
    @report = Report.new
    @reports = Report.all
  end

  def create
    @reports = Report.all
    @report = Report.new(report_params)
    @report.save
  end

  def edit
    @report = Report.find(params[:id])
      if current_user.is_admin == true
        render "edit"
      else
        redirect_to user_path(current_user)
      end
  end

  def update
    @report = Report.find(params[:id])
    @report.update(report_params)
    redirect_to root_path
  end

  def destroy
    @reports = Report.all
    @report = Report.find(params[:id])
    @report.destroy
  end

  private

  def report_params
    params.require(:report).permit(:image, :title, :body)
  end
end
