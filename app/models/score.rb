class Score < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('start_date') }
  validates :start_date, presence: true
  validates :team_top, presence: true, length: { maximum: 10 }
  validates :team_bottom, presence: true, length: { maximum: 10 }
  validates :user_id, presence: true
end
