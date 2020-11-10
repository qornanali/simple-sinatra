require './app/db/database_client'

class Food
  TABLE_NAME = 'foods'
  attr_accessor :name, :price
  attr_reader :errors, :id

  def initialize(id = nil, name, price)
    @id = id
    @name = name
    @price = price
    @errors = []
  end

  def save
    @id = insert_to_database(name: @name, price: @price).to_i
    self
  end

  def all
    result_set = select_from_database
    result_set.map do |item|
      Food.new(item['id'].to_i, item['name'].to_s, item['price'].to_i)
    end
  end

  def valid?
    @errors = []
    @errors << 'name cannot be nil' if name.nil?
    @errors << 'price cannot be nil' if price.nil?
    @errors.empty?
  end

  def ==(other)
    return false if other.nil? || other.class != self.class

    @id == other.id && @name == other.name && @price == other.price
  end

  def hash
    name.hash + price.hash
  end

  private

    def insert_to_database(params)
      columns = params.keys.map { |key| key.to_s }.join(', ')
      values = params.keys.map { |key| "\'#{params[key].to_s}\'" }.join(', ')
      sql = "INSERT INTO #{TABLE_NAME} (#{columns}) VALUES (#{values});"
      database_client.execute_manipulation(sql)
    end

    def select_from_database(fields = [], limit = 10, offset = 0)
      columns = fields.empty? ? '*' : fields.map { |val| "#{TABLE_NAME}.val" }.join(',')
      sql = "SELECT #{columns} FROM #{TABLE_NAME} LIMIT #{limit} OFFSET #{offset};"
      database_client.execute_query(sql)
    end

    def database_client
      ::DatabaseClient.build
    end
end
