# src/components/attachments/item_component.cr
class Attachments::ItemComponent < BaseComponent
  needs attachment : Attachment

  def render
    @common_suffix = "#{attachment.attachable.class.to_s.underscore}_#{attachment.file_type}"
    li id: "li_#{attachment.file}" do
      div class: "btn-group btn-group-xs", role: "group" do
        # It's caught and managed through JQuery-ujs
        # use .bind("ajax:success",..  to suscribe to events
        link Attachments::Delete.with(file: attachment.file), id: attachment.file,
         class: "uploaded_attachment #{@common_suffix}_file",
           "data-remote": "true",
           "data-confirm": "¿Desea eliminar adjunto?",
           "data-disable-with": "Procesando..." do
          span class: "fa fa-times danger"
          text " "
          span attachment.file_name
          input(type: "hidden", value: attachment.file, attrs: [:required])
        end
      end
    end
    render_js
  end

  def render_js
    script do
      raw <<-JAVASCRIPT
      $('a[id="#{attachment.file}"]').bind("ajax:success", function (event, data, status, xhr) {
          $('li[id="li_#{attachment.file}"]').remove();
        });
      JAVASCRIPT
    end
  end
end

