require 'trello'

namespace :update_analytics do
  desc "Updates all analytics per user"
  task all: :environment do
    users = User.all
    users.each do |user|
      gpa = GpaCalculator.new(user)
    end
  end
end
