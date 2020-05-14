class LinkSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :digest, :url
end
