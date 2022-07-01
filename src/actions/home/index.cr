class Home::Index < BrowserAction
  get "/" do
    html Home::IndexPage, operation: CreateSourceFile.new
  end
end
