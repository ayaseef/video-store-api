require "test_helper"

describe Video do
  let(:video) { videos(:wonder_woman) }

  it "can be instantiated" do
    expect(video.valid?).must_equal true
  end

  describe "validations" do
    it 'is valid when required fields are present' do
      video = videos(:wonder_woman)
      result = video.valid?
      expect(result).must_equal true
    end

    it 'is invalid with available inventory of less than zero' do
      video = videos(:wonder_woman)
      video.available_inventory = -1
      result = video.valid?
      expect(result).must_equal false
    end
    
    it 'is valid with available inventory of zero' do
      video = videos(:wonder_woman)
      video.available_inventory = 0
      result = video.valid?
      expect(result).must_equal true
    end

    it 'is valid with available inventory of greater than zero' do
      video = videos(:wonder_woman)
      result = video.valid?
      expect(result).must_equal true
    end

    it 'is invalid with available inventory that is not an integer' do
      video = videos(:wonder_woman)
      video.available_inventory = "Kaida is awesome!!!"
      result = video.valid?
      expect(result).must_equal false
    end

    it 'must have an available_inventory' do
      video = videos(:wonder_woman)
      video.available_inventory = nil
      result = video.valid?
      expect(result).must_equal false
    end

    it 'must have a video title' do
      video = videos(:wonder_woman)
      video.title = nil
      result = video.valid?
      expect(result).must_equal false
    end

    it 'must have a video overview' do
      video = videos(:wonder_woman)
      video.overview = nil
      result = video.valid?
      expect(result).must_equal false
    end

    it 'must have a video total_inventory' do
      video = videos(:wonder_woman)
      video.total_inventory = nil
      result = video.valid?
      expect(result).must_equal false
    end

    it 'must have a video release_date' do
      video = videos(:wonder_woman)
      video.release_date = nil
      result = video.valid?
      expect(result).must_equal false
    end
  end

  describe "relations" do
    it "has many rentals" do
      wonder_woman = videos(:wonder_woman)
      expect(wonder_woman).must_respond_to :rentals
      wonder_woman.rentals.each do |rental|
        expect(rental).must_be_kind_of Rental
      end
    end

    it "has many customers" do
      wonder_woman = videos(:wonder_woman)
      expect(wonder_woman).must_respond_to :customers
      wonder_woman.customers.each do |customer|
        expect(customer).must_be_kind_of Customer
      end
    end
  end
end
