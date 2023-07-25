require './lib/practice'
require 'json'

RSpec.describe '#calulate_discounted_prices' do
  xit 'returns object with discount product prices' do
    data = {
      "products": [
        {
          "name": "Product A",
          "price": 12.99
        },
        {
          "name": "Product B",
          "price": 7.49
        },
        {
          "name": "Product C",
          "price": 55.00
        }
      ]
    }.to_json

    response = calulate_discounted_prices(data)
    expect(response).to be_a String
    response = JSON.parse(response, symbolize_names: true)
    expect(response[:products].count).to eq(3)

    expect(response[:products][2][:price]).to eq(55.00)
  end

  it 'applies 5% discount when price is less than $10' do
    data = {
      "products": [
        {
          "name": "Product A",
          "price": 12.99
        },
        {
          "name": "Product B",
          "price": 7.49
        },
        {
          "name": "Product C",
          "price": 55.00
        }
      ]
    }.to_json

   
    response = calulate_discounted_prices(data) 
    expect(response[:products][1][:price]).to eq(7.49)
  end

  it 'applies 10% discount when price is between $10-$50' do
    data = {
      "products": [
        {
          "name": "Product A",
          "price": 12.99
        },
        {
          "name": "Product B",
          "price": 50
        },
        {
          "name": "Product C",
          "price": 10.00
        }
      ]
    }.to_json
    
    response = JSON.parse(calulate_discounted_prices(data), symbolize_names: true)
    expect(response[:products].first[:price]).to eq(11.69)
    expect(response[:products][1][:price]).to eq(45.00)
    expect(response[:products][2][:price]).to eq(9.00)
  end

  it 'applies 20% discount when price is greater than than $50' do
    data = {
      "products": [
        {
          "name": "Product A",
          "price": 12.99
        },
        {
          "name": "Product B",
          "price": 50.01
        },
        {
          "name": "Product C",
          "price": 55.00
        }
      ]
    }.to_json

    response = calulate_discounted_prices(data) 

    expect(response[:products][1][:price]).to eq(40.01)
    expect(response[:products][2][:price]).to eq(55.00)
  end
end