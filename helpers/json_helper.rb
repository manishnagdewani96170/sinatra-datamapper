module JsonHelper

  def send_ok(data)
    data = {} unless data
    content_type :json
    data.to_json
  end

  def send_error(message, data)
    data = {} unless data
    content_type :json
    {
      error: message
    }.to_json
  end
end
