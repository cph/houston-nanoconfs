Houston::Nanoconf::Engine.routes.draw do

  scope "nanoconfs" do
    get "", to: "presentations#index", as: "presentations"
    get ":id", to: "presentations#show", as: "presentation"
    get ":id/edit", to: "presentations#edit", as: "edit_presentation"
    patch ":id", to: "presentations#update", as: "update_presentation"
  end
end
