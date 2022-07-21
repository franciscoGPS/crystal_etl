
# src/components/source_files/bar_chart_component.cr
class SourceFiles::BarChartComponent < BaseComponent
  needs column_metadata : Hash(String, Array(Hash(String, String)))

  def render
    div data_controller: "d3" do
      chart_id = "d3-container-#{column_metadata.keys.first.to_s}-#{Time.local.to_unix_ms}"
      div class: "grid-dt-chart", 
        id: chart_id,
        data_d3_target: "chart",
        data_column_metadata_value: "#{column_metadata.values.first.to_json}",
        data_column_name_value: chart_id
    end
  end
end

