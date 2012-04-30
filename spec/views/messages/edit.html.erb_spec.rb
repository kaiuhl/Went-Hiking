require 'spec_helper'

describe "messages/edit" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :body => "MyText",
      :subject => "MyString",
      :from => 1
    ))
  end

  it "renders the edit message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path(@message), :method => "post" do
      assert_select "textarea#message_body", :name => "message[body]"
      assert_select "input#message_subject", :name => "message[subject]"
      assert_select "input#message_from", :name => "message[from]"
    end
  end
end
