module ApplicationHelper
  def weight_name
    case weight
    when 1
      "Easy"
    when 2
      "Medium"
    when 3
      "Hard"
    when 4
      "Extreme"
    else
      "Unknown"
    end
  end
end
