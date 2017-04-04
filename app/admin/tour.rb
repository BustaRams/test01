ActiveAdmin.register Tour do

  controller do
    def permitted_params
      params.permit(:tour => [:name, :description, :owner_id, :start_time, :category_id])
      # params.permit! # allow all parameters
    end
  end

end
