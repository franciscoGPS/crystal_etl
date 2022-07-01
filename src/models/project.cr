class Project < BaseModel
  #skip_default_columns
  macro default_columns
    primary_key id : UUID
    timestamps
  end
  table do
    column url : String?
    column check_md5 : String
    column content : JSON::Any?
    column public_id : UUID
  end
end
