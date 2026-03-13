# == Schema Information
#
# Table name: post_likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#
class PostLike < ApplicationRecord
end
