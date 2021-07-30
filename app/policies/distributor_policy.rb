class DistributorPolicy < ApplicationPolicy
  attr_reader :user, :distributor

  def initialize(user, distributor)
    @user = user
    @distributor = distributor
  end

  def index?
    true
  end

  def show?
    true
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
    user.emea_admin_access? || user.admin? || user.super_admin?
  end

end
