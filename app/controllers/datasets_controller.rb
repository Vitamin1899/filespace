class DatasetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  #before_action :set_dataset, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @datasets = Dataset.all
    respond_with(@datasets)
  end

  def create
    #@dataset = Dataset.new(dataset_params.merge({ user_id: current_user.id }))
    #@dataset.save
    @dataset = current_user.datasets.create(dataset_params)
    redirect_to datasets_path, notice: "The file has been uploaded."
  end

  def destroy
    @dataset.destroy
    respond_with(@dataset)
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
