
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
        
        lucky_file = Shrine::UploadedFile.new(source_file.file, "store")
        dataframe = Crysda.read_csv(lucky_file.url, separator: ',',  na_value: "")
        SourceFileQuery.new.each do |source_file|
          pp source_file
        end
        json({ data: build_json_response(dataframe),
               title: source_file.file_name,
               metadata: build_dataframe_stats(dataframe)})
      else
        head 500
      end
    end
  end

  def build_dataframe_stats(df)
    MetadataBuilder.new(df).to_json
  end

  def build_json_response(df)
    json_arr = [] of String
    df.cols.each_with_index do |col, index|
      json_arr << CellBuilder.new(0, index, col.name).to_json
    end
    df.cols.each_with_index do |col, col_index|
      col.values.each_with_index do |val, row_index|
        json_arr << CellBuilder.new(row_index + 1, col_index, val).to_json
      end
    end
    json_arr
  end
end
