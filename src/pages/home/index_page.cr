
class Home::IndexPage < MainLayout
  needs operation : CreateSourceFile

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
          div class: "card-footer" do
           
          end
        end
      end
    end
    div class: "row d-flex justify-content-center" do
      div class: "col-xs-12 col-sm-8" do
        div id: "luckysheet" do
          text "O bien, puedes agregar aquí tu formato"
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



  private def render_projects_form(op)
    #form(method: "post", class: "custom-form", action: SourceFile::Create.path) do
    #  file_input(op.content, attrs: [:required], class: "custom-input")
    #end
    form_for(SourceFile::Create, class: "inline-form", enctype: "multipart/form-data") do
      raw "<input type=\"file\"
       id=\"source_file:content\"
       name=\"source_file:content\"
       value=\"\"
       class=\"custom-input\"
       required />" 
      #file_input(op.content, attrs: [:required], class: "custom-input")
      submit "Guardar", class: "btn float-right login_btn"
    end
   
  end

  private def sign_in_fields(op)
    div class: "input-group form-group" do
      # :append_class or :replace_class for mounted fields
      # replace is used to remove locally defined class
      mount Shared::Field.new(op.email, "fa fa-user"), &.email_input(placeholder: "Correo electrónico", autofocus: "true", append_class: "form-control")
    end
    div class: "input-group form-group" do
      mount Shared::Field.new(op.password, "fa fa-key"), &.password_input(placeholder: "Contraseña", append_class: "form-control")
    end

   
  end
end
