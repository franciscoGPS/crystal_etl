# src/components/attachments/item_component.cr
class Attachments::DeletedItemComponent < BaseComponent
  needs result : String
  needs item_id : String

  def render
    script do
      raw <<-JAVASCRIPT
        $(document).ready(function(){
          alert("error");
        });  
      JAVASCRIPT
    end
  end
end

