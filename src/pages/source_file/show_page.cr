class SourceFile::ShowPage < MainLayout
  needs source_file : SourceFile

  def content
    h1 "Proyecto guardado", class: "title"
    div do
      h3 "Url:  #{@source_file.url}"
    end
    peoject_details(@source_file)
  end

  private def peoject_details(source_file)
    ul do
      link "Descargar public UUID: #{source_file.public_id} ",  SourceFile::Download.with(public_id: source_file.public_id)
    end
  end
end
