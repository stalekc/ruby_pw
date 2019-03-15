require 'rails_helper'

RSpec.describe "forums/edit", type: :view do
  before(:each) do
    @forum = assign(:forum, Forum.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit forum form" do
    render

    assert_select "form[action=?][method=?]", forum_path(@forum), "post" do

      assert_select "input[name=?]", "forum[name]"
    end
  end
end
