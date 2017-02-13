ActiveAdmin.register Category do

  controller do
    def permitted_params
      params.permit(:category => [:name])
      # params.permit! # allow all parameters
    end
  end
end
