class SourceFile::AsyncUploader < BaseComponent
  needs operation : SaveSourceFile

  needs file_type : String
  needs form_id : String

  def render
    
    @common_suffix = "#{Time.local.to_s}_#{file_type}"
    div data_controller: "uploads", class: "container"  do
      form_for SourceFile::Create,
        class: "upload_#{@common_suffix}",
        id: "upload_#{@common_suffix}",
        data_target: "upload_form",
        multipart: true do
          div class: "row" do
            input(type: "file", 
            id: "async_att",
            value: "source_file:lucky_file",
            name: "source_file:lucky_file",
            class: "async_att",
            data_uploads_target: "uploadInput",
            data_action: "change->uploads#send_file")
          end
          div class: "row" do
            input(type: "hidden", value: file_type, id: "attachment_file_type", name: "source_file:file_type")
          end

        render_uploaded_files
      end
    end
  end

  def render_uploaded_files
    div data_target: "uploaded_files", class: "row justify-content-between text-left" do
      ul id: "attachments_container" do

      end
    end
  end

  def render_js

    script do

      raw <<-JAVASCRIPT

      var form = document.getElementById("#{form_id}");
      if (form != undefined){
        if (form.attachEvent) {
            form.attachEvent("submit", processAttachmentsForm);
        } else {
            form.addEventListener("submit", processAttachmentsForm);
        }
      }

      function processAttachmentsForm(e) {
        appendConsolidatedField();
      }

      function appendConsolidatedField(){
        var form = document.getElementById("#{form_id}");

        files = getItems()
        var ids = document.getElementById("sale_attachments_ids");
        if (ids){
          ids.remove();
        }
        var input = document.createElement("input");
        input.type = "text";
        input.id = "sale_attachments_ids";
        input.name = "sale:attachments_ids";
        input.setAttribute("hidden", "hidden");
        input.setAttribute("value", files);
        form.appendChild(input);
      }

      function getItems(){
        var files_ul = document.getElementsByClassName("uploaded_attachment");
        var item_array = [];
        for (var i = 0; i < files_ul.length; i++) {
            var str_to_appenf = files_ul[i].id
            if (str_to_appenf != ""){
              item_array.push(str_to_appenf);
            }
        }
        return item_array.join(",");
      }

      $( document ).on('turbolinks:load', function() {
    
        function append_component_post_upload(data){

          var my_div_existing_html = $("#attachments_container").html();
          $("#attachments_container").html(my_div_existing_html + data);
        }
        
        function reset_uploader_field(){
          $("#btn_submit_upload").prop("disabled", false);
          $("#async_att").val("");
        }

        $("input:file.async_att").change(function(e) {
          token = $("[name ='token']").val();

          var data = new FormData();
          $.each($('#async_att')[0].files, function(i, file) {
              data.append('attachment:lucky_file', file);
          });

          // If you want to add an extra field for the FormData
          // data.append("CustomField", "This is some extra data, testing");
          // disabled the submit button
          $("#btn_submit_upload").prop("disabled", true);

          attachable_id = $("#attachable_id").val();
          attachment_file_type = $("#attachment_file_type").val();
          attachablefile_type = $("#attachment_attachable").val();
          data.append("file_type", attachment_file_type);
          data.append("attachable", attachablefile_type);

          $.ajax({
            url: '/attachments/'+attachable_id,
            type: "post",
            contentType: false,
            processData: false,
            cache: true,
            data: data,
            headers: {
              "Accept": "application/json",
              "contentType": "application/json; charset=utf-8",
              "token": token,
            },
            success: function (data) {

              append_component_post_upload(data);
              reset_uploader_field();
             
              appendConsolidatedField();
            },
            error: function (error) {
              console.log("ERROR : ", error);
              $("#btn_submit_upload").prop("disabled", false);

              reset_uploader_field();
            }
          });
          e.preventDefault();
        });
      });

      JAVASCRIPT
    end
  end

  def render_pdf_download_button(file_id, label_text)
    mount DownloadDocumentButton, label: label_text, file_id: file_id.not_nil!
  end
end