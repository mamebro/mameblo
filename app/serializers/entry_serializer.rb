class EntrySerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :beans_count

  def content
    object.content_as_markdown
  end

  def beans_count
    object.bean.count
  end

  has_one :brother
end
