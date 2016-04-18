module PageHelper
  def is_home?
    request.fullpath == '/'
  end

  def get_copyright_message
    year = Date.today.cwyear
    I18n.t(:copyright) + ' ' + year.to_s + '. ' + I18n.t(:all_rights_reserved)
  end
end
