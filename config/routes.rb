Houston::Nanoconfs::Engine.routes.draw do

  scope "nanoconfs" do
    get "", to: "presentations#index", as: "presentations"
    get "new", to: "presentations#new", as: "new_presentation"
    post "", to: "presentations#create", as: "create_presentation"
    get ":id", to: "presentations#show", as: "presentation"
    get ":id/edit", to: "presentations#edit", as: "edit_presentation"
    patch ":id", to: "presentations#update", as: "update_presentation"
  end
end
