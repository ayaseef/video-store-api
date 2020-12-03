class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  def check_out_video
    if self.video.available_inventory > 0
      self.customer.videos_checked_out_count += 1
      self.video.available_inventory -= 1

      return false unless self.customer.save
      return false unless self.video.save

      return self.save
    end
  end
end
