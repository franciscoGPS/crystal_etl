

class SourceFile::Create < BrowserAction
  skip protect_from_forgery
  
  post "/source_files" do
    lucky_file = params.nested_file("source_file")["lucky_file"]

    SaveSourceFile.create(lucky_file: lucky_file, file_name: lucky_file.filename ) do |op, attachment|
      if attachment
        #attachment = AttachmentQuery.new.preload_attachable.find(attachment.id)
        #component Attachments::ItemComponent, attachment: attachment
        #json(AttachmentSerializer.new(attachment), HTTP::Status::CREATED)
        raw_json("Successfully created", HTTP::Status::CREATED)
      else
        head 500
      end
    end
  end
end
