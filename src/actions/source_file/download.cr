
class SourceFile::Download < BrowserAction
  
  get "/source_file/:public_id" do
    source_file = SourceFileQuery.new.public_id.nilable_eq(public_id).first
    if source_file
      filename = "tests/#{source_file.url.to_s}"
      flash.info = "Archivo a descargar: #{filename}"
      file filename, filename: filename, disposition: "attachment", content_type: "pdf"
    else
      flash.failure = "Archivo no encontrado"
      redirect to: Home::Index
    end
  end
end
