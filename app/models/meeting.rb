class Meeting < ApplicationRecord
  include DocumentRelatable

  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged finders scoped], scope: :neighborhood

  belongs_to :neighborhood
  has_and_belongs_to_many :works

  validates_presence_of :date, :objectives, :lookup_address

  default_scope { order(date: :asc) }

  def next
    Meeting.where(neighborhood_id: neighborhood_id).where("date > ?", date).order(date: 'asc').first
  end

  def prev
    Meeting.where(neighborhood_id: neighborhood_id).where("date < ?", date).order(date: 'desc').first
  end

  private

  def formatted_date
    date.strftime('%d-%m-%Y')
  end

  def slug_candidates
    [
      :formatted_date,
      [:formatted_date, :lookup_address]
    ]
  end
end



