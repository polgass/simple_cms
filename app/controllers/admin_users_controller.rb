class AdminUsersController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in

  def index
    @editors = AdminUser.sorted
  end

  def new
    @editor = AdminUser.new
  end

  def create
    @editor = AdminUser.new(editor_params)
    if @editor.save
      flash[:notice] = "Editor successfully saved."
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @editor = AdminUser.find(params[:id])
  end

  def update
    @editor = AdminUser.find(params[:id])
    if @editor.update_attributes(editor_params)
      flash[:notice] = "Editor successfully updated."
      redirect_to(:action => 'index')
    else
      render('edit')
    end
  end

  def delete
    @editor = AdminUser.find(params[:id])
  end

  def destroy
    AdminUser.find(params[:id]).destroy
    flash[:notice] = "Editor successfully deleted."
    redirect_to(:action => 'index')
  end

  private

    def editor_params
      params.require(:editor).permit(:last_name, :first_name, :email, :username, :password, :password_confirmation)
    end
end
