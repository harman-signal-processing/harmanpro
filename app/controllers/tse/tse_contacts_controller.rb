class Tse::TseContactsController < TseController
  respond_to :json

  def index
    @contacts = TseContact.where(name: "something-that-doesn't-exist")
    TseCategory.default_contact_sort_order.each do |category|
      @contacts += category.tse_contacts
      category.children.each do |sub_category|
        @contacts += sub_category.tse_contacts
      end
    end
    respond_with @contacts
  end

  def show
    respond_with TseContact.find(params[:id])
  end

end


