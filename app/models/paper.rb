class Paper
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :user
  field :title, type: String
  field :markdown, type: String
end
