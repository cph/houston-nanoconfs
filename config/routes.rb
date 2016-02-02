Houston::Nanoconf::Engine.routes.draw do

  scope "nanoconf" do
    get "", to: "presentations#index"
  end
end
