class Paper
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :user
  field :title, type: String
  field :markdown, type: String
  validates_presence_of :title
  validates_presence_of :markdown

  def render
  	markdown = Tilt::RDiscountTemplate.new {self.markdown}
  	markdown.render.html_safe
  end
end
