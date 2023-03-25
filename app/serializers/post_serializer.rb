class PostSerializer < ActiveModel::Serializer
  attributes :title, :content, :short_content

  belongs_to :author
  has_many :tags

  def short_content
    object.content.truncate(43, omission: '...')
    # "#{self.object.content[0-39]...}"
  end
end
