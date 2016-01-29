class MainController < ApplicationController

  def index
    @vertical_markets = VerticalMarket.parent_verticals
  end

  def sitemap
    @vertical_markets = VerticalMarket.all
    respond_to do |format|
      format.html
      format.xml { build_xml_sitemap_pages }
    end
  end

  private

  def build_xml_sitemap_pages
    @pages = []
    @pages << {
      url: root_url,
      updated_at: 1.day.ago,
      changefreq: 'daily',
      priority: 1
    }
    add_brands_to_sitemap
    add_vertical_markets_to_sitemap
    add_events_to_sitemap
    add_other_pages_to_sitemap
  end

  def add_vertical_markets_to_sitemap
    @vertical_markets.each do |vertical_market|
      @pages << {
        url: vertical_market_url(vertical_market),
        updated_at: vertical_market.updated_at,
        changefreq: 'weekly',
        priority: 0.9
      }
      vertical_market.reference_systems.each do |reference_system|
        @pages << {
          url: vertical_market_reference_system_url(vertical_market, reference_system),
          updated_at: reference_system.updated_at,
          changefreq: 'weekly',
          priority: 0.8
        }
      end
      vertical_market.case_studies.each do |case_study|
        @pages << {
          url: vertical_market_case_study_url(vertical_market, case_study),
          updated_at: case_study.updated_at,
          changefreq: 'monthly',
          priority: 0.7
        }
      end
    end
  end

  def add_events_to_sitemap
    @pages << { url: events_url, updated_at: 1.week.ago, changefreq: 'weekly', priority: 0.6 }
    Event.current_and_upcoming.each do |event|
      if event.featured?
        @pages << {
          url: event_url(event),
          updated_at: event.updated_at,
          changefreq: 'monthly',
          priority: 0.5
        }
      end
    end
  end

  def add_brands_to_sitemap
    all_brands.each do |brand|
      @pages << {
        url: brand_url(brand),
        updated_at: brand.updated_at,
        changefreq: 'monthly',
        priority: 0.4
      }
    end
  end

  def add_other_pages_to_sitemap
    @pages << { url: training_url, updated_at: 1.week.ago, changefreq: 'weekly', priority: 0.3 }
    @pages << { url: contacts_url, updated_at: 1.week.ago, changefreq: 'weekly', priority: 0.3 }
    @pages << { url: consultants_url, updated_at: 1.week.ago, changefreq: 'weekly', priority: 0.4 }
    @pages << { url: service_url, updated_at: 1.week.ago, changefreq: 'weekly', priority: 0.2 }
    @pages << { url: service_centers_url, updated_at: 1.week.ago, changefreq: 'weekly', priority: 0.3 }
    @pages << { url: new_service_center_url, updated_at: 1.week.ago, changefreq: 'weekly', priority: 0.3 }
    @pages << { url: service_center_login_url, updated_at: 1.week.ago, changefreq: 'weekly', priority: 0.2 }
  end

end
