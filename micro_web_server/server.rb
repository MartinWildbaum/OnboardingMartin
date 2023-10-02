require 'sinatra'
require 'dotenv/load'
require_relative 'wishlist_item'
require 'pg'

DB = PG.connect(
  dbname: ENV['DB_NAME'],
  user: ENV['USER'],
  password: ENV['DB_PASS']
)

set :public_folder, File.dirname(__FILE__) + '/public'
set :views, File.join(File.dirname(__FILE__), 'views')

$items = WishlistItem.all
$budget = 1000 # Initial budget

def sort_items_by_cost
  $items.sort_by!(&:cost)
end

def check_affordable_items
  available_budget = $budget
  $items.each do |item|
    if item.cost <= available_budget
      item.completed = true
      available_budget -= item.cost
    else
      item.completed = false
    end
  end
end

get '/' do
  @filtered_items ||= $items
  erb :index
end

post '/add_item' do
  description = params[:description]
  cost = params[:cost].to_f
  if !description.empty? && cost >= 0
    item = WishlistItem.new(description, cost, false)
    item.save
  end
  $items = WishlistItem.all
  redirect '/'
end

post '/optimize' do
  budget = params[:budget].to_f
  if budget >= 0
    $budget = budget
    sort_items_by_cost
    check_affordable_items
  end
  redirect '/'
end

get '/search' do
  search_query = params[:text_to_filter]
  if search_query
    # Decided not to make it case sensitive.
    @filtered_items = $items.select { |item| item.name.downcase.include?(search_query.downcase) }
  else
    @filtered_items = $items
  end
  erb :index
end
