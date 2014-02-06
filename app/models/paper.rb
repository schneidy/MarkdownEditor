class Paper
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :user
  field :title, type: String
  field :markdown, type: String
  validates_presence_of :title
  validates_presence_of :markdown
end
