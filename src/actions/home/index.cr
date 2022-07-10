class Home::Index < BrowserAction
  get "/" do
    html Home::IndexPage, operation: CreateSourceFile.new, files: SourceFileQuery.new
  end
end
