class CreateProjects::V20220701001234 < Avram::Migrator::Migration::V1
  def migrate
    
    create table_for(Project) do
      primary_key id : UUID
      add content : JSON::Any?
      add url : String?
      add public_id : UUID
      add_timestamps
      add check_md5 : String, index: true, unique: true
    end
  end

  def rollback
    drop table_for(Project)
  end
end
