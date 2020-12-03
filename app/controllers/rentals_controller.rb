class RentalsController < ApplicationController
  def check_out
    rental = Rental.new(due_date: Date.today + 7.days)

    if rental.save && rental.is_available?
      rental.customer.videos_checked_out_count += 1
      rental.video.available_inventory -= 1

      render json: rental.as_json(only: [:customer_id, :video_id, :due_date, :video_checked_out_count, :available_inventory]), status: :created
    else
      # bad request
      render json: {
          ok: false,
          errors: rental.errors.messages
      }, status: :bad_request
      return
    end

  end
end
