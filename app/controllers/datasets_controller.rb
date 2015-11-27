class DatasetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :set_dataset, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @datasets = Dataset.order_by(:created_at => 'desc')
    respond_with(@datasets)
  end

  def create
    @dataset = current_user.datasets.create(dataset_params)
    redirect_to datasets_path, notice: "The file has been uploaded."
  end

  def destroy
    if @dataset.user == current_user
      @dataset.destroy
      redirect_to datasets_path, notice: "The file has been deleted."
    else
      redirect_to datasets_path, notice: "The file can not be deleted."
    end
  end

  def file
    @dataset = Dataset.find(params[:id])
    send_data(@dataset.file.read,
          :type => @dataset.file.content_type,
          :disposition => 'inline',
          :url_based_filename => false)
  end

  private
    def set_dataset
      @dataset = Dataset.find(params[:id])
    end

    def dataset_params
      params.require(:dataset).permit(:file, :user_id)
    end
end
