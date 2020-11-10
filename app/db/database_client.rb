class DatabaseClient
  @instance = new

  private_class_method :new

  def self.build
    @instance
  end

  def execute_query(sql)
    execute(sql)
  ensure
    client.close
  end

  def execute_manipulation(sql)
    execute(sql)
    client.last_id
  ensure
    client.close
  end

  private

    def execute(sql)
      client.query(sql)
    end

    def client
      return @client unless @client.nil? || @client.closed?

      @client = ::Mysql2::Client.new(
        host: ENV['DATABASE_HOST'],
        username: ENV['DATABASE_USERNAME'],
        password: ENV['DATABASE_PASSWORD'],
        database: ENV['DATABASE_NAME'],
        port: ENV['DATABASE_PORT']
      )
    end
end
