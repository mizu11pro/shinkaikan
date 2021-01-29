class Users::HomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_report, only: [:edit, :update, :destroy]

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
    if current_user.is_admin == true
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    if @report.update(report_params)
      redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy
    @reports = Report.all
    @report.destroy
  end

  private

  def report_params
    params.require(:report).permit(:image, :title, :body)
  end

  def set_report
     @report = Report.find(params[:id])
  end
end
