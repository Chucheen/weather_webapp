class ::Weather::ResultContract < Dry::Validation::Contract
  params do
    optional(:lat).maybe(:float)
    optional(:lon).maybe(:float)
    optional(:city_name).maybe(:string)
  end

  rule(:lat, :lon, :city_name) do
    key(:request_errors).failure('Only set lat and lon together or city_name alone') if
      values[:lat] && values[:lon] && values[:city_name]
    key(:request_errors).failure('Please provide lat and lon, or city name') if
      values[:lat].nil? && values[:lon].nil? && values[:city_name].blank?
  end
end