require "json"

class CellBuilder
  include JSON::Serializable

  def to_json
    JSON.build do |json|
      json.object do
        json.field "r", @position.row
        json.field "c", @position.col
        json.field "v" do
          json.object do
            json.field "v", @value.keep
            json.field "m", @value.display
            json.field "ct" do
              json.object do
                json.field "fa", @format.definition
                json.field "t", @format.type
              end
            end
            json.field "ff", "Google Sans,Roboto,RobotoDraft,Helvetica,Arial,sans-serif"
          end
        end
        
      end
    end
  end

  def initialize(x,y,val)
    
    @position = CellPosition.new(x,y)
    @format = CellFormat.new
    @value = CellValue.new(val.to_s, val.to_s)
  end

  struct CellFormat
    include JSON::Serializable

    getter definition : String
    getter type : String
    def initialize
      @definition = "General"
      @type = "g"
    end

    def initialize(@definition : String, @type : String)
      @definition = "General"
      @type = "g"
    end
  end

  struct CellPosition
    include JSON::Serializable

    getter row : Int32
    getter col : Int32
  
    def initialize(@row : Int32, @col : Int32)
    end
  end

  struct CellValue
    include JSON::Serializable
    
    getter keep : String
    getter display : String
   
    def initialize(@keep : String, @display : String)

    end
  end
end