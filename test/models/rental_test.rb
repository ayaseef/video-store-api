require "test_helper"

describe Rental do
  let(:rental) { Rental.create(customer: customers(:customer_one), video: videos(:black_widow)) }

  describe "validations" do
    it 'is valid when required fields are present' do
      result = rental.valid?
      expect(result).must_equal true
    end

    it 'must have a valid customer ID' do
      rental.customer_id = nil
      result = rental.valid?
      expect(result).must_equal false
    end

    it 'must have a valid video ID' do
      rental.video_id = nil
      result = rental.valid?
      expect(result).must_equal false
    end
  end
  describe "relationaships" do
    it "belongs to customer" do
      rental.must_respond_to :customer
      (rental.customer).must_be_kind_of Customer
    end

    it "belongs to video" do
      rental.must_respond_to :video
      (rental.video).must_be_kind_of Video
    end
  end

end

