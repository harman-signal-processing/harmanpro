class Tse::TseContactsController < TseController
  respond_to :json

  def index
    @contacts = TseContact.where(name: "something-that-doesn't-exist")
    TseCategory.ordered_parents.each do |category|
      @contacts += category.tse_contacts
      category.children.order(:position).each do |sub_category|
        @contacts += sub_category.tse_contacts
      end
    end
    respond_with @contacts
  end

  def show
    respond_with TseContact.find(params[:id])
  end

end


