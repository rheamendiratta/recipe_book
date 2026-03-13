# == Schema Information
#
# Table name: post_comments
#
#  id           :bigint           not null, primary key
#  comment_text :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  post_id      :integer
#  user_id      :integer
#
class PostComment < ApplicationRecord
end
