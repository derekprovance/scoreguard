json.array!(@goals) do |goal|
  json.extract! goal, :id, :name, :attended, :starts_at
  json.url goal_url(goal, format: :json)
end
