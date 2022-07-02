

class SourceFile::Create < BrowserAction
  skip protect_from_forgery
  accepted_formats [:json], default: :json
  
  post "/source_files" do
    lucky_file = params.nested_file("source_file")["lucky_file"]

    SaveSourceFile.create(lucky_file: lucky_file, file_name: lucky_file.filename ) do |op, source_file|
      if source_file
        #attachment = AttachmentQuery.new.preload_attachable.find(attachment.id)
        #component Attachments::ItemComponent, attachment: attachment
        #json(AttachmentSerializer.new(attachment), HTTP::Status::CREATED)
        print_file_gympse(source_file)
        plain_text "Successfully created"
      else
        head 500
      end
    end
  end

  def print_file_gympse(file)
  
    lucky_file = Shrine::UploadedFile.new(file.file, "store")

    flights = Crysda.read_csv(lucky_file.url, separator: ',')

    flights.cols.each do |col|
      pp col.name
      pp col.values
    end
    
  end
end
