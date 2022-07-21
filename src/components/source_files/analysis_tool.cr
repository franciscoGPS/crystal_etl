
class SourceFiles::AnalysisTool < BaseComponent
  needs source_file : SourceFile

  def render
    lucky_file = Shrine::UploadedFile.new(source_file.file, "store")
    df = Crysda.read_csv(lucky_file.url, separator: ',')

    div class: "grid" do
      count_by_value(df).each_with_index do |column, index|
        div class: "grid-item draggable" do
          mount SourceFiles::BarChartComponent, column_metadata: column
        end
      end
      
    end
  end

  def count_by_value(df)
    #result = [] of Hash(String, Array(Hash(String, String)))
    df.cols.map do |col|
      counts_df = df.count(col.name)
      { counts_df.cols[0].name => counts_df.cols[0].values.map_with_index { |val, index| { "key" => val.to_s , "value" => counts_df.cols[1].values[index].to_s } }  } 
    end
  end
end

