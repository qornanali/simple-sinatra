require './app/models/food'

RSpec.describe Food do
  describe '#valid?' do
    subject { tested_object.valid? }
    let(:tested_object) { described_class.new(name, price) }

    context 'when the parameters are valid' do
      let(:name) { 'foo' }
      let(:price) { 200 }

      it { is_expected.to eq true }
    end

    context 'when parameter name is nil' do
      let(:name) { nil }
      let(:price) { 200 }

      it { is_expected.to eq false }
    end

    context 'when parameter price is nil' do
      let(:name) { 'foo' }
      let(:price) { nil }

      it { is_expected.to eq false }
    end
  end

  describe '#errors' do
    subject { tested_object.errors }
    let(:tested_object) { described_class.new(name, price) }

    before(:each) do
      tested_object.valid?
    end

    context 'when validation succeed' do
      let(:name) { 'foo' }
      let(:price) { 200 }

      it { is_expected.to be_empty }
    end

    context 'when all parameters are nil' do
      let(:name) { nil }
      let(:price) { nil }

      it { is_expected.to eq ['name cannot be nil', 'price cannot be nil'] }
    end
  end

  describe '#==' do
    subject { tested_object }
    let(:tested_object) { described_class.new(name, price) }
    let(:name) { 'foo' }
    let(:price) { 200 }

    context 'when other object is nil' do
      let(:other_object) { nil }

      it { is_expected.to_not eq other_object }
    end

    context 'when other object is not the same class' do
      let(:other_object) { String.new }

      it { is_expected.to_not eq other_object }
    end

    context 'when other object has different value on its attributes' do
      context 'when id is different' do
        let(:other_object) { described_class.new(1, name, price) }

        it { is_expected.to_not eq other_object }
      end

      context 'when name is different' do
        let(:other_object) { described_class.new('random', price) }

        it { is_expected.to_not eq other_object }
      end

      context 'when price is different' do
        let(:other_object) { described_class.new(name, 100) }

        it { is_expected.to_not eq other_object }
      end
    end

    context 'when other object has same value on each attributes' do
      let(:other_object) { described_class.new(name, price) }

      it { is_expected.to eq other_object }
    end
  end

  describe '#hash' do
    subject { tested_object.hash }
    let(:tested_object) { described_class.new(name, price) }
    let(:name) { 'foo' }
    let(:price) { 200 }

    it { is_expected.to eq (name.hash + price.hash) }
  end

  describe '#save' do
    subject { tested_object.save }
    let(:tested_object) { described_class.new(name, price) }
    let(:name) { 'foo' }
    let(:price) { 200 }
    let(:expected_result) do
      described_class.new(recorded_food['id'], recorded_food['name'], recorded_food['price'])
    end
    let(:recorded_food) do
      mysql_client.query('select * from foods order by id desc limit 1;').first
    end
    let(:mysql_client) do
      Mysql2::Client.new(
        host: ENV['DATABASE_HOST'],
        username: ENV['DATABASE_USERNAME'],
        password: ENV['DATABASE_PASSWORD'],
        database: ENV['DATABASE_NAME'],
        port: ENV['DATABASE_PORT']
      )
    end

    after do
      mysql_client.close
    end

    it { is_expected.to eq expected_result }
  end

  describe '#all' do
    subject { tested_object.all }
    let(:tested_object) { described_class.new(name, price) }
    let(:name) { 'foo' }
    let(:price) { 200 }

    context 'when records are empty' do
      it { is_expected.to eq [] }
    end

    context 'when there is a record' do
      let(:expected_result) do
        described_class.new(recorded_food['id'], recorded_food['name'], recorded_food['price'])
      end
      let(:recorded_food) do
        mysql_client.query('select * from foods order by id desc limit 1;').first
      end
      let(:mysql_client) do
        Mysql2::Client.new(
          host: ENV['DATABASE_HOST'],
          username: ENV['DATABASE_USERNAME'],
          password: ENV['DATABASE_PASSWORD'],
          database: ENV['DATABASE_NAME'],
          port: ENV['DATABASE_PORT']
        )
      end

      before do
        mysql_client.query("INSERT INTO foods (name, price) VALUES ('foo', 200);")
      end

      after do
        mysql_client.close
      end

      it { is_expected.to eq [expected_result] }
    end
  end
end
