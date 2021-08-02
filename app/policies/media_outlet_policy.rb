class MediaOutletPolicy < ApplicationPolicy
  attr_reader :user, :media_outlet

  def initialize(user, media_outlet)
    @user = user
    @media_outlet = media_outlet
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
    user.admin? || user.super_admin? || user.pr_admin_access?
  end

end
