module ApplicationHelper
  # This super helper allows me to use External Linked SVG Files :)
  # <%= embedded_svg('frame-mesh') %> This lins is use to render in HTML
  def embedded_svg(filename, options = {})
    assets = Rails.application.assets
    asset = assets.find_asset(filename)

    if asset
      file = asset.source.force_encoding("UTF-8")
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css "svg"
      svg["class"] = options[:class] if options[:class].present?
    else
      doc = "<!-- SVG #{filename} not found -->"
    end

    raw doc
  end

  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end
end
