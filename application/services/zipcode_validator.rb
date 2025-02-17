class ZipcodeValidator
  def initialize(zipcode)
    @zipcode = zipcode
  end

  def search_address(object)
    address = ViaCep::Address.new(zipcode)

    object.address = address.address
    object.neighborhood = address.neighborhood
    object.city = address.city
    object.state = address.state

  rescue ViaCep::ApiRequestError => _error
  end
end
