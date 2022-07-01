class Downloader < BaseComponent
  needs label : String
  needs file_id : String

  def render
    link  SourceFile::DownloadFile.with(file_id), class: "btn btn-outline-primary" do
      span class: "fa fa-download"
      span " #{label}"
    end
  end
end
