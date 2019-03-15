require 'rails_helper'

RSpec.describe "forums/new", type: :view do
  before(:each) do
    assign(:forum, Forum.new(
      :name => "MyString"
    ))
  end

  it "renders new forum form" do
    render

    assert_select "form[action=?][method=?]", forums_path, "post" do

      assert_select "input[name=?]", "forum[name]"
    end
  end
end
