require "json"
require "crysda"

class MetadataBuilder
  include JSON::Serializable

  def to_json
    return unless @file.present?

    JSON.build do |json|
      json.array do 
        @file.df.cols.each_with_index do |col, index|
          json.field index.to_s do
            json.object do
              json.field "name", col.name
              json.field "type", col.class.to_s.split("::").last.split("Col").first
              json.field "size", col.values.size.to_s
              json.field "empty", empty_values(col.values)
              json.field "resume", col.to_s
            end
          end
        end
      end
    end
  end

  def initialize(df)
    @file = FileMetadata.new(df)
  end

  def empty_values(values)
    values.map { |i| i.to_s.strip.empty? }.select(true).size
  end

  struct FileMetadata
    include JSON::Serializable

    getter df : Crysda::DataFrame

    def initialize(@df)
    end
  end
end