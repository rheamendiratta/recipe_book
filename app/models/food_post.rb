# == Schema Information
#
# Table name: food_posts
#
#  id         :bigint           not null, primary key
#  caption    :text
#  photo_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :integer
#  user_id    :integer
#
class FoodPost < ApplicationRecord
end
