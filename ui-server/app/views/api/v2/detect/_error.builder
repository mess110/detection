xml.error do
  xml.code params[:error_code]
  xml.description format_error_description params[:error_description]
end
