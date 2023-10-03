class WishlistItem
  attr_accessor :name, :cost, :completed

  def initialize(name, cost, completed = false)
    @name = name
    @cost = cost
    @completed = completed
  end

  def save
    begin
      DB.exec_params(
        'INSERT INTO wishlist_items (name, cost, completed) VALUES ($1, $2, $3)',
        [@name, @cost, @completed]
      )
    rescue PG::UniqueViolation => e
      # Handle the case where an item with the same name already exists. It does not make sense to have it repeated
      puts "Item with name #{@name} already exists in the database."
    end
  end

  def self.all
    result = DB.exec('SELECT * FROM wishlist_items')
    result.map do |row|
      WishlistItem.new(row['name'], row['cost'].to_f, row['completed'] == 't')
    end
  end
end
