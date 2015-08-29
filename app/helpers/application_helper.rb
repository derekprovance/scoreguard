module ApplicationHelper
  def weight_name
    case weight
    when 1
      "Green"
    when 2
      "#00FF99"
    when 3
      "Red"
    when 4
      "Black"
    else
      "Unknown"
    end
  end
end
