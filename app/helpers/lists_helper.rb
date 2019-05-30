module ListsHelper
  def user_is_authorized_for_lists?
    current_user && (current_user == list.user || current_user.admin?)
  end
end
