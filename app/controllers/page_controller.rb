class PageController < IndexController
  layout '1-column'

  def home
    @title = I18n.t :title
    @description = I18n.t :meta_description
    @keywords = I18n.t :meta_keywords
    @page = Page.find_by(url_key: 'home')
  end

  def show
    @page = Page.find_by(url_key: params[:page])
    if @page.nil?
      render template: 'page/not_found', layout: 'empty'
    end
  end

  def not_found
  end
end
