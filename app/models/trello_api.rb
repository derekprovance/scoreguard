class TrelloApi

  def get_boards
    trello_init
    # derek = Trello::Member.find("derekprovance1")
    # war_room = Trello::Board.find("52d41c3c5e6ec6027b917c6d")
    # TODO - Automatically find and store List IDs
    @goals ||= Trello::List.find("52e68c30b5276d1b500efba1")
    @bonus ||= Trello::List.find("548532b7158b03e693f4aa64")
    @accomplished ||= Trello::List.find("538dfcf098249c145d2ef179")
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
      config.developer_public_key ||= '8ffdd706d5db9f282d059937a6b479e4' # The "key" from step 1
      config.member_token ||= '993b764ed44751dc501aa68f0b041d48501e6bb19fffbf4f1043586691adb7e8' # The token from step 3.
    end
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
