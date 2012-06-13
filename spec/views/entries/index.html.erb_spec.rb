require 'spec_helper'

describe "entries/index" do
  before(:each) do
    assign(:entries, [
      stub_model(Entry,
        :user_id => 1,
        :content => "Content",
        :title => "Title"
      ),
      stub_model(Entry,
        :user_id => 1,
        :content => "Content",
        :title => "Title"
      )
    ])
  end

  it "renders a list of entries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
