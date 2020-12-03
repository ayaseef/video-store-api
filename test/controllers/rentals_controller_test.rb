require "test_helper"

describe RentalsController do
  describe "check_out" do
    before do
      post checkout_path
    end
    it "can check out a video to a customer" do

    end

    it "cannot check out a video if the customer does not exist and returns not found" do

    end

    it "cannot check out a video if the video does not exist and returns not found" do

    end

    it "cannot check out a video if the video does not have any available inventory and returns bad request" do

    end
  end
end
