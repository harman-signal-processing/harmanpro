class UserPolicy
  attr_reader :user, :user_in_question

  def initialize(user, user_in_question)
    @user = user
    @user_in_question = user_in_question
  end

  def index?
    @user.admin? || @user.super_admin?
  end

  def show?
    can_access_user?
  end

  def edit?
    can_access_user?
  end

  def update?
    can_access_user?
  end

  def destroy?
    can_access_user?
  end

  private

  def can_access_user?
    (@user_in_question.emea_distributor? && @user.emea_admin_access?) ||
      @user.admin? || @user.super_admin? ||
      @user == @user_in_question
  end
end
