class CreateSourceFile::V20220701003952 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(SourceFile) do
      primary_key id : UUID
      add_timestamps
      add content : JSON::Any?
      add metadata : JSON::Any?      
      add url : String?
      add public_id : UUID
      add md5_sum : String, index: true, unique: true
      add file : String
      add file_name : String
      add file_type : String
      add confirmed : Bool = false

      # For each polymorphic association
      # add_belongs_to device : Device?, on_delete: :do_nothing
      # add_belongs_to sale : Sale?, on_delete: :do_nothing
    end
  end

  def rollback
    drop table_for(SourceFile)
  end
end
