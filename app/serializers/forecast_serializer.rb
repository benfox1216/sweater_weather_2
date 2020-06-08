class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :current, :hourly, :daily
end
