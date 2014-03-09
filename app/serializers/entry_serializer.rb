class EntrySerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :number_of_beans

  def content
    object.content_as_markdown
  end

  def number_of_beans
    object.bean.count
  end

  has_one :brother
end
