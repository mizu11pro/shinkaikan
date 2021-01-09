class Customers::HomesController < ApplicationController

  def index
    @report = Report.all
  end
end
