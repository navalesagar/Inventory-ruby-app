require 'sinatra'
require 'sequel'
require 'json'

set :bind, '0.0.0.0'
set :port, 4567
set :public_folder, File.dirname(__FILE__) + '/public'

# Connect to Postgres with retry
DB = nil
5.times do
  begin
    DB = Sequel.connect(
      adapter: 'postgres',
      host: 'db',
      database: 'inventory',
      user: 'postgres',
      password: 'postgres',
      port: 5432  # use container's default port
    )
    puts "Connected to DB!"
    break
  rescue
    puts "Waiting for DB..."
    sleep 5
  end
end

# Models
class Product < Sequel::Model(:products); end
class Store < Sequel::Model(:stores); end
class Sale < Sequel::Model(:sales); end

# Routes
## Products
# get '/' do
#   "Inventory API is running"
# end

get '/products' do
  content_type :json
  Product.all.map(&:values).to_json
end

post '/products' do
  data = JSON.parse(request.body.read)
  product = Product.create(
    name: data["name"],
    price: data["price"],
    quantity: data["quantity"]
  )
  { message: "Product added", product_id: product.id }.to_json
end

## Stores
get '/stores' do
  content_type :json
  Store.all.map(&:values).to_json
end

post '/stores' do
  data = JSON.parse(request.body.read)
  store = Store.create(name: data["name"])
  { message: "Store added", store_id: store.id }.to_json
end

## Sales
get '/sales' do
  content_type :json
  Sale.all.map(&:values).to_json
end

post '/sales' do
  data = JSON.parse(request.body.read)
  sale = Sale.create(
    product_id: data["product_id"],
    store_id: data["store_id"],
    quantity: data["quantity"]
  )
  { message: "Sale recorded", sale_id: sale.id }.to_json
end