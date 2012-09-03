require 'spec_helper'

describe "messages/new" do
  before(:each) do
    assign(:message, stub_model(Message,
      :body => "MyText",
      :subject => "MyString",
      :from => 1
    ).as_new_record)
  end

  it "renders new message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path, :method => "post" do
      assert_select "textarea#message_body", :name => "message[body]"
      assert_select "input#message_subject", :name => "message[subject]"
      assert_select "input#message_from", :name => "message[from]"
    end
  end
end
