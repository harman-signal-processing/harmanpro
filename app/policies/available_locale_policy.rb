class AvailableLocalePolicy < ApplicationPolicy
  attr_reader :user, :object

  def initialize(user, object)
    @user = user
    @object = object
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

