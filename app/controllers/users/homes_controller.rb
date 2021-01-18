class Users::HomesController < ApplicationController

  def index
    @report = Report.new
    @reports = Report.all
  end

  def create
    @report = Report.new(report_params)
    @report.save
    redirect_to root_path
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    @report.update(report_params)
    redirect_to root_path
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to root_path
  end

  private

  def report_params
    params.require(:report).permit(:image, :title, :body)
  end
end
