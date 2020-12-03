class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  def is_available?
    return self.video.available_inventory > 0
  end
end
