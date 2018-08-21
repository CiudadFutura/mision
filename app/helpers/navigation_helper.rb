module NavigationHelper
  def ensure_navigation
    @navigation ||= [ { :title => 'Home', :url => '/' } ]
  end

  def navigation_add(title, url)
    ensure_navigation << { :title => title, :url => url }
  end

  def render_navigation
    render :partial => 'layouts/navigation', :locals => { :nav => ensure_navigation }
  end
end