require 'sinatra'

# We have four images we can serve up. If we add more,
# update BASELIN_RANGE accordingly
BASELINE_RANGE = (1 .. 4)

def normalize_value(input_number)

  # A bit cheeky here. No matter what value is sent, split
  # the string into individual digits, grab the last, and
  # convert into an int. This will save some cycles on
  # reducing to a value that falls within the BASELINE_RANGE
  # later on.
  input_number = input_number.split('').last.to_i

  return 1 if input_number == 0

  while !BASELINE_RANGE.include?(input_number)
    input_number -= BASELINE_RANGE.last
  end
  input_number
end

options "*" do
  200
end

before do
  response.headers["Access-Control-Allow-Origin"]   = "*"
  response.headers["Access-Control-Allow-Methods"]  = "PUT, POST"
end

get '/' do
  status 200
  'I am alive!'
end

get '/images/:name' do

  normalized_params = normalize_value( params[:name] )
  puts "Sending: #{normalized_params}.jpg for Request: #{params[:name]}"
  send_file "#{normalized_params}.jpg"

end