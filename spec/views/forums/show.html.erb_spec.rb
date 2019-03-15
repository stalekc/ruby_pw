require 'rails_helper'

RSpec.describe "forums/show", type: :view do
  before(:each) do
    @forum = assign(:forum, Forum.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
