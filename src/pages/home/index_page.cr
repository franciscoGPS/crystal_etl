
class Home::IndexPage < MainLayout

  needs operation : CreateSourceFile
  needs files : SourceFileQuery

  def content
    div class: "row d-flex justify-content-center h-100 mt-5" do
      div class: "col-xs-12 col-sm-8" do
        div class: "card" do
          div class: "card-header card-header-standard" do
            h1 "Nuevo proyecto"
          end
          div class: "card-body" do
            render_pdf_upload_sale_receipt
          end
        end
      end
    end
    div data_controller: "source-files", class: "row d-flex justify-content-center" do
      div class: "col-xs-12 " do
        files.each do |source_file|
          mount SourceFiles::AnalysisTool, source_file: source_file
        end
      end
    end
  end

  def render_pdf_upload_sale_receipt
    mount SourceFile::AsyncUploader,
    operation: SaveSourceFile.new,
    file_type: "datasource",
    form_id: ""
  end
end
