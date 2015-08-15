class TrelloApiController < ApplicationController
  attr_accessor :api_keys

  def initialize(current_user)
    @user_id = current_user.id
    @api_keys = get_api_keys
    if @api_keys.nil?
      set_api_keys
    end
  end

  def get_last_updated
    AppApi.where(user_id: @user_id).first.try(:last_updated)
  end

  def get_api_keys
    AppApi.where(user_id: @user_id).first.try(:api_keys)
  end

  def set_api_keys
    # TODO - need to implement this function
  end
end
