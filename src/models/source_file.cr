class SourceFile < BaseModel
  #skip_default_columns
  macro default_columns
    primary_key id : UUID
    timestamps
  end
  table do
    column url : String?
    column md5_sum : String
    column metadata : JSON::Any?
    column content : JSON::Any?
    column public_id : UUID
    column file : String
    
    column file_name : String
    column file_type : String
    column confirmed : Bool

    # belongs_to device : Device?
    # belongs_to sale : Sale?
    # polymorphic attachable, associations: [:sale, :device]
  end
end
