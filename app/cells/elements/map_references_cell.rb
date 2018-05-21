class Elements::MapReferencesCell < Cell::ViewModel

  private

  def base
    return [] if model.blank?
    reference_number = 0
    model.map do |neighborhood|
      reference_number += 1
      case neighborhood[:geometry].geometry_type
        when RGeo::Feature::Polygon
        {
          coordinates: neighborhood[:geometry].coordinates.first.map(&:reverse),
          className: 'base-geometry',
          name: neighborhood[:name],
          reference: reference_number
        }
        when RGeo::Feature::MultiPolygon
        {
          coordinates: neighborhood[:geometry].coordinates.first.first.map(&:reverse),
          className: 'base-geometry',
          name: neighborhood[:name],
          reference: reference_number
        }
      end
    end.to_json
  end

  def map_defaults
    MAP.merge(
      "marker_shadow_url" => image_url(MAP["marker_shadow_url"]),
      "marker_editable_url" => image_url(MAP["marker_editable_url"]),
    ).to_json
  end
end
