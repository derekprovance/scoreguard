class Apis::TrelloApi

  attr_accessor :current_user, :api_keys

  def initialize(current_user)
    @current_user = current_user

    @api_keys = get_api_keys
    if @api_keys.nil?
      set_api_keys
    end
  end

  def get_boards
    war_room = trello_init

    @goals ||= war_room.lists.select{ |x| x.name == 'Goals for this week' }.first
    @bonus ||= war_room.lists.select{ |x| x.name == 'Bonus Round' }.first
    @accomplished ||= war_room.lists.select{ |x| x.name == 'Accomplished this Week!' }.first
  end

  def get_total_value
    get_boards
    goal_values = card_points(@goals)
    earned_values = card_points(@accomplished)
    goal_values[:easy] + earned_values[:easy] + goal_values[:medium] + earned_values[:medium] + goal_values[:hard] + earned_values[:hard]
  end

  def get_earned_value
    get_boards
    earned_values = card_points(@accomplished)
    earned_values[:easy] + earned_values[:medium] + earned_values[:hard] + earned_values[:bonus]
  end

  def is_setup?
    AppApi.where(user_id: @current_user.id).any?
  end

  def get_last_updated
    AppApi.where(user_id: @current_user.id).first.try(:last_updated)
  end

  def get_last_updated=(new_date)
    api = AppApi.where(user_id: @current_user.id).first
    api.last_updated = new_date
    api.save!
  end

  def get_api_keys
    AppApi.where(user_id: @current_user.id).first.try(:api_keys)
  end

  def set_api_keys
    # TODO - need to implement this function
  end

  private

  def trello_init
    Trello.configure do |config|
      config.developer_public_key ||= api_keys['public_key']
      config.member_token ||= api_keys['member_token']
    end

    Trello::Board.find(api_keys['points_board'])
  end

  def card_points(column)
    values = { easy: 0, medium: 0, hard: 0, bonus: 0 }

    column.cards.each do |card|
      if card.labels.select{ |l| l.name == 'Easy' }.size > 0
        values[:easy] += 1
      elsif card.labels.select{ |l| l.name == 'Medium' }.size > 0
        values[:medium] += 2
      elsif card.labels.select{ |l| l.name == 'Hard' }.size > 0
        values[:hard] += 3
      elsif card.labels.select{ |l| l.name == 'Bonus' }.size > 0
        values[:bonus] += 1
      end
    end

    values
  end

end
#
