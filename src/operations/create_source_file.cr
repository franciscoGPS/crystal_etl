class CreateSourceFile < SourceFile::SaveOperation
  param_key :source_file
  permit_columns content, metadata, url, public_id, md5_sum

end