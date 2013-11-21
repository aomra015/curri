class StudentsController < ApplicationController

  before_action :authorize

  def update_status
    @current_user.classrole.toggle(:help).save
    redirect_to :back, notice: "Help status toggled."
  end

end