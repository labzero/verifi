Overview:
You can use this gem to access Verifi.com's hosted payment page API for creating and reading payment requests.

Installation:

sudo gem install verifi

Usage:

require 'verifi'

verifi = Verifi::Client.new YOUR_API_KEY, YOUR_SECRET_KEY

payment_params = {
     :amount => '123.00',
     :currency => 'USD',
     :orderid => '123',
     :return_url => 'http://yoursite.com/order_complete',
     :cancel_url => 'http://yoursite.com/continue_shopping',
     :failure_url => 'http://yoursite.com/order_failure',
     :request_type => 'sale'
    }

#Creating a payment request:
payment_request = verifi.create_payment_request payment_params

puts "just made payment request with pay_key: #{payment_request['pay_key']}"

#Reading the payment request:

fetched_payment_request = verifi.read_payment_request payment_request['pay_key']

