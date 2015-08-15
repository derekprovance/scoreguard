class Apis::TrelloApi

  attr_accessor :current_user, :api

  def initialize(current_user)
    @current_user = current_user
    @api = TrelloApiController.new(current_user)
  end

  def get_boards
    war_room = trello_init

    @goals ||= war_room.lists.select{ |x| x.name == 'Goals for this week' }.first
    @bonus ||= war_room.lists.select{ |x| x.name == 'Bonus Round' }.first
    @accomplished ||= war_room.lists.select{ |x| x.name == 'Accomplished this Week!' }.first
  end

  def get_total_value
    get_boards
    total_values = card_points(@goals)
    total_values[:easy] + total_values[:medium] + total_values[:hard] + total_values[:bonus]
  end

  def get_earned_value
    get_boards
    earned_values = card_points(@accomplished)
    earned_values[:easy] + earned_values[:medium] + earned_values[:hard] + earned_values[:bonus]
  end

  private

  def trello_init
    # TODO - Store API keys

    Trello.configure do |config|
      config.developer_public_key ||= api.api_keys['public_key']
      config.member_token ||= api.api_keys['member_token']
    end

    Trello::Board.find(api.api_keys['points_board'])
  end

  def card_points(column)
    values = { easy: 0, medium: 0, hard: 0, bonus: 0 }

    column.cards.each do |card|
      if card.labels.select{ |l| l.name == 'Easy' }.size > 0
        values[:easy] += 1
      elsif card.labels.select{ |l| l.name == 'Medium' }.size > 0
        values[:medium] += 1
      elsif card.labels.select{ |l| l.name == 'Hard' }.size > 0
        values[:hard] += 1
      elsif card.labels.select{ |l| l.name == 'Bonus' }.size > 0
        values[:bonus] += 1
      end
    end

    values
  end

end
