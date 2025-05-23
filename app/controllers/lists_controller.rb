class ListsController < ApplicationController
  # Un utilisateur peut voir toutes les listes
  def index
    @lists = List.all
  end

  # Un utilisateur peut voir les détails d’une liste donnée et son nom
  def show
    @list = List.find(params[:id])
  end

  # Un utilisateur peut créer une nouvelle liste
  def new
    @list = List.new
  end
  
  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path, notice: 'List was successfully created.'
    else
      render :new
    end
  end
  
  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name)
  end
  
end
