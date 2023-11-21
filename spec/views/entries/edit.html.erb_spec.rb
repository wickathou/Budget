require 'rails_helper'

RSpec.describe "entries/edit", type: :view do
  let(:entry) {
    Entry.create!(
      name: "MyString",
      user: nil
    )
  }

  before(:each) do
    assign(:entry, entry)
  end

  it "renders the edit entry form" do
    render

    assert_select "form[action=?][method=?]", entry_path(entry), "post" do

      assert_select "input[name=?]", "entry[name]"

      assert_select "input[name=?]", "entry[user_id]"
    end
  end
end
