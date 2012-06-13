require 'spec_helper'

describe "mame blog(static_pages)" do

  subject { page }

  describe "Home" do
    before{ visit root_path }

    it { should have_selector 'h1',  text: "mameblog" }

  end
end
