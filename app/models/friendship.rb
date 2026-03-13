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
end
