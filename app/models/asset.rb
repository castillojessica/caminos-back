class Asset < ApplicationRecord

  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged finders history]
  enum verification: [:verification_pending, :verification_rejected, :verification_approved]

  belongs_to :neighborhood

  acts_as_taggable_on :categories

  scope :within, -> (point) {
    lat = point.coordinates[0]
    lng = point.coordinates[1]
    where("ST_Distance(geometry, 'POINT(#{lat} #{lng})') = 0" )
  }

  validates_presence_of(
    :category_list,
    :description,
    :geo_geometry,
    :geometry,
    :lookup_address,
    :name,
  )

  validate :valid_categories

  CATEGORIES = %w[
    community_center
    cult
    education
    food_kitchen
    health
    infrastructure
    public_organization
    public_spaces
  ].freeze


  private_constant :CATEGORIES

  def self.categories
    CATEGORIES
  end

  def self.verification_status
    verifications.keys
  end

  def self.icon(category)
    ActionController::Base.helpers.image_url("icons/category-asset-#{category}.svg")
  end

  def valid_categories
    errors.add(:category_list, "errors") unless category_list.present?
  end

  def category
    tags_on(:categories).first
  end

  def category_icon
    category.blank? ? ActionController::Base.helpers.image_url('icons/category-asset-editable.svg') : ActionController::Base.helpers.image_url("icons/category-asset-#{category}.svg")
  end

  def category_icon_shadow
    category.blank? ? 'icons/category-asset-editable.svg' : "icons/category-asset-#{category}-shadow.svg"
  end

  def slug_candidates
    [
        :name,
        [:name, :description],
        [:name, :description, :id]
    ]
  end

end
