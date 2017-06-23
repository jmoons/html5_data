require 'sinatra'

BASELINE_RANGE = (1 .. 4)
def normalize_value(input_number)
  return input_number if input_number == 0
  input_number = input_number.abs if input_number < 0

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
  # matches "GET /hello/foo" and "GET /hello/bar"
  # params['name'] is 'foo' or 'bar'
  # "Hello #{params['name']}!"
  files_to_send     = [ "1.jpg", "2.jpg", "3.jpg", "4.jpg" ]
  normalized_params = normalize_value( params[:name].to_i )
  puts "Sending: #{normalized_params}.jpg for Request: #{params[:name]}"
  send_file "#{normalized_params}.jpg"
  # send_file files_to_send[ normalized_params - 1 ]

end