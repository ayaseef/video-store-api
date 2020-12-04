require "test_helper"

describe RentalsController do
  before do
    @customer = customers(:customer_one)
    @video = videos(:wonder_woman)

    @request_body = {
        customer_id: @customer.id,
        video_id: @video.id
    }
  end

  describe "check_out" do
    it "can check out a video to a customer" do
      expect {
        post checkout_path, params: @request_body
      }.must_change "Rental.count", 1

      # does a find_by
      @customer.reload

      must_respond_with :ok

      expect(@customer.videos_checked_out_count).must_equal 4
    end

    it "cannot check out a video if the customer does not exist and returns not found" do
      @request_body[:customer_id] = nil

      expect {
        post checkout_path, params: @request_body
      }.wont_change "Rental.count"

      must_respond_with :not_found
    end

    it "cannot check out a video if the video does not exist and returns not found" do
      @request_body[:video_id] = nil

      expect {
        post checkout_path, params: @request_body
      }.wont_change "Rental.count"

      must_respond_with :not_found
    end

    it "cannot check out a video if the video does not have any available inventory and returns bad request" do
      @video.available_inventory = 0
      @video.save!

      expect {
        post checkout_path, params: @request_body
      }.wont_change "Rental.count"

      must_respond_with :bad_request
    end
  end

  describe "check_in" do
    # use reload when checking before and after counts
    it "can check in a video for a customer" do
      post checkout_path, params: @request_body
      rental = Rental.find_by(customer_id: @request_body[:customer_id], video_id: @request_body[:video_id])
      expect(rental).wont_be_nil

      expect {
        post checkin_path, params: @request_body
      }.wont_change "Rental.count"

      # does a find_by
      @customer.reload

      must_respond_with :ok

      expect(@customer.videos_checked_out_count).must_equal 3
    end

    it "cannot check out a video if the customer does not exist and returns not found" do
      # @request_body[:customer_id] = nil
      #
      # expect {
      #   post checkout_path, params: @request_body
      # }.wont_change "Rental.count"
      #
      # must_respond_with :not_found
    end

    it "cannot check out a video if the video does not exist and returns not found" do
      # @request_body[:video_id] = nil
      #
      # expect {
      #   post checkout_path, params: @request_body
      # }.wont_change "Rental.count"
      #
      # must_respond_with :not_found
    end

    it "cannot check out a video if the video does not have any available inventory and returns bad request" do
      # @video.available_inventory = 0
      # @video.save!
      #
      # expect {
      #   post checkout_path, params: @request_body
      # }.wont_change "Rental.count"
      #
      # must_respond_with :bad_request
    end
  end
end
