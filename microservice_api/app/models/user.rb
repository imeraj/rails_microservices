class User < ApplicationRecord
  after_save :notify_added
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :phone_number, presence: true
  validates :full_name,  presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }

  def notify_added
    UserMailer.send_confirmation(self).deliver
  end
end
