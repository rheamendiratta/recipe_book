# == Schema Information
#
# Table name: friendships
#
#  id           :bigint           not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  addressee_id :integer
#  requester_id :integer
#
class Friendship < ApplicationRecord
  belongs_to :requester, required: true, class_name: "User", foreign_key: "requester_id"
  belongs_to :addressee, required: true, class_name: "User", foreign_key: "addressee_id"

  STATUSES = %w[pending accepted declined].freeze
  validates :status, inclusion: { in: STATUSES }

  scope :pending, -> { where(status: "pending") }
  scope :accepted, -> { where(status: "accepted") }
  scope :declined, -> { where(status: "declined") }

  def pending?; status == "pending"; end
  def accepted?; status == "accepted"; end
  def declined?; status == "declined"; end

  def accept!; update!(status: "accepted"); end
  def decline!; update!(status: "declined"); end
end
