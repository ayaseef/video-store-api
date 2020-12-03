class RentalsController < ApplicationController
  def check_out
    customer = Customer.find_by(id: params[:customer_id])
    video = Video.find_by(id: params[:video_id])
    if customer.nil? || video.nil?
      render json: {
          "errors": [
              "Not Found"
          ]
      }, status: :not_found
      return
    end

    rental = Rental.new(customer_id: customer.id, video_id: video.id, due_date: Date.today + 7.days)

    if rental.is_available?
      if rental.save
        customer.videos_checked_out_count += 1
        customer.save
        video.available_inventory -= 1
        video.save

        render json: rental.as_json(only: [:customer_id, :video_id, :due_date]).merge(
            videos_checked_out_count: customer.videos_checked_out_count,
            available_inventory: video.available_inventory), status: :ok
      end
    else
      render json: {
          ok: false,
          errors: rental.errors.messages
      }, status: :bad_request
      return
    end
  end
end
