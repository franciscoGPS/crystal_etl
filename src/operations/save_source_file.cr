class SaveSourceFile < SourceFile::SaveOperation

  param_key :source_file
  permit_columns file, file_name, file_type, confirmed, public_id, id, md5_sum

  SUPPORTED_FORMATS = [/csv/i]

  attribute lucky_file : Lucky::UploadedFile

  before_save do
  
    confirmed.value = false

    lucky_file.value.try do |uploaded_file|
      shrine_file = upload_pdf(uploaded_file)
      file.value = shrine_file.id
      file_type.value =  "csv"
      file_name.value = uploaded_file.filename
    end
    save_md5_sum
    generate_ids
    validate_required file_name
  end

  before_save validate_file_extension

  def validate_file_extension
    file_name.value.try do |filename|
      unless SUPPORTED_FORMATS.reject{|format| !filename.ends_with?(format) }.any?
        file_name.add_error "Archivo no soportado"
      end
    end
  end

  def generate_ids
    id.value = UUID.random
    public_id.value = UUID.random
  end

  def save_md5_sum
    lucky_file.value.try do |value|
      md5_sum.value = UUID.random.to_s
    end
  end

  private def upload_pdf(incoming_file)
    Shrine.upload(File.open(incoming_file.tempfile.path), "store", metadata: { "filename" => incoming_file.filename })
  end
end
