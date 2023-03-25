class PostSerializer < ActiveModel::Serializer
  attributes :title, :content

  belongs_to :author
  has_many :tags

  def short_content
    posts.content.length > 40 ? "#{posts.content[0..39]}..." : posts.content
  end
end
