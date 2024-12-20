class VerticalMarketPolicy < ApplicationPolicy
  attr_reader :user, :vertical_market

  def initialize(user, vertical_market)
    @user = user
    @vertical_market = vertical_market
  end

  def index?
    admin?
  end

  def show?
    admin?
  end

  def new?
    admin?
  end

  def create?
    admin?
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  private

  def admin?
    user.admin? || user.super_admin?
  end
end
