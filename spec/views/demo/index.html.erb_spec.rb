require 'rails_helper'

RSpec.describe "demo/index.html.erb", :type => :view do
  it "displays the response page" do
    render
    expect(rendered).to include("Response")
  end
end
