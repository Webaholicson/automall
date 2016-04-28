class ListingController < IndexController
  layout '1-column'

  def show
  end

  def new
  end

  def saved
  end

  def list
    if request.post?
      @filters = params[:listing]
    end
  end

  def save
  end

  def delete
  end

  def edit
  end
end
