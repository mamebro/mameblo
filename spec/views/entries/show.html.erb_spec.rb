require 'spec_helper'

describe "entries/show" do
  before(:each) do
    @entry = assign(:entry, stub_model(Entry,
      :user_id => 1,
      :content => "Content",
      :title => "Title"
    ))
  end

  pending "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Content/)
    rendered.should match(/Title/)
  end
end
