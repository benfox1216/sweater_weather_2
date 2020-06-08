class LatLongSerializer
  include FastJsonapi::ObjectSerializer
  attributes :lat, :long
end
