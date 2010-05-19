require File.dirname(__FILE__) + '/../lib/verifi'

describe Verifi::Client do
  it "should be configurable on creation" do
    client = Verifi::Client.new '123', '123'
    client.should_not be_nil
  end

  it "should be able to create payment request details" do
    client = Verifi::Client.new "e430e360a05704105c5f7a40314dd021", \
                                "b4d7e651d92af2953faf241f68f763a4", \
                                "http://localhost:3000"

    pr = client.create_payment_request base_params

#    puts "just created pr: #{pr.inspect}"

    pr['pay_key'].should_not be_nil
#    puts "just got pay_key: #{pr['pay_key']}"
  end

  it "should be able to read payment request details" do
    client = Verifi::Client.new "e430e360a05704105c5f7a40314dd021", \
                                "b4d7e651d92af2953faf241f68f763a4", \
                                "http://localhost:3000"

    pr = client.create_payment_request base_params
    fetched_pr = client.read_payment_request pr['pay_key']

#    puts "just fetched pr: #{pr.inspect}"

    fetched_pr['pay_key'].should_not be_nil
  end

  def base_params
    {
     :amount => '123.00', :orderid => '123', :return_url => 'foo.com',
     :cancel_url => 'cancel.com', :failure_url => 'failure.com',
     :request_type => 'sale', :currency => 'USD'
    }
  end


end