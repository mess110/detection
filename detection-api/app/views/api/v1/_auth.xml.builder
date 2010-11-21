xml.user do
  xml.mail response[:email]
  xml.api_key do
    xml.key response[:key]
    xml.secret response[:secret]
  end
end
