class EmeaPagePolicy
  attr_reader :user, :emea_page

  def initialize(user, emea_page)
    @user = user
    @emea_page = emea_page
  end

  def index?
    true
  end

  def show?
    @emea_page.published? || admin?
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

  def edit_template?
    admin?
  end

  private

  def admin?
    @user.try(:admin?)
  end

end
