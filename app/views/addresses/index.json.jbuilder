json.array!(@addresses) do |address|
  json.extract! address, :id, :first_name, :last_name, :address1, :address2, :contact_number, :city, :user_id
  json.url address_url(address, format: :json)
end
