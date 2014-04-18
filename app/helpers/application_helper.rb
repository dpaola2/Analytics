module ApplicationHelper
  def avatar_url(email)
    if email.nil?
      nil
    else
      gravatar_id = Digest::MD5.hexdigest(email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png"
    end
  end
end
