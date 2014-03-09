require 'spec_helper'

describe EntrySerializer do
  let(:brother) do
    password = 'nejimakid0ri'
    FactoryGirl.create(:brother, name: 'kumiko', password: password, password_confirmation: password)
  end
  let(:entry) { FactoryGirl.create(:entry) }
  let(:number_of_beans) { 3 }

  let(:pattern) do
    {
      id: entry.id,
      title: entry.title,
      content: entry.content_as_markdown,
      number_of_beans: number_of_beans,
      brother: {
        id: entry.brother.id,
        name: entry.brother.name
      }
    }
  end

  before do
    number_of_beans.times do
      FactoryGirl.create(:bean, entry_id: entry.id, throw_brother_id: brother.id)
    end
  end

  subject do
    described_class.new(entry).as_json root: false
  end

  it do
    should match_json_expression(pattern)
  end
end
