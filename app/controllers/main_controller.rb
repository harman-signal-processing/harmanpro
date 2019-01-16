class MainController < ApplicationController

  def index
    @vertical_markets = VerticalMarket.parent_verticals
    @slides = @current_locale.homepage_slides
    if @geo_ip.found?
      @slides = @slides.where("geo_target_country IS NULL or geo_target_country = ?", @geo_ip.country.iso_code)
    end
    @featured_case_studies = CaseStudy.featured
    @event = Event.current_and_upcoming.
      where(featured: true).
      where("start_on < ?", 6.months.from_now).
      where("start_on > ?", 1.day.ago).
      order(Arel.sql("start_on ASC")).first
  end

  def sitemap
    @vertical_markets = VerticalMarket.active
    respond_to do |format|
      format.html
      format.xml { build_xml_sitemap_pages }
    end
  end

  # For akamai's route testing
  def sureroute
    # Load some content just to slow things down as a real-world example
    Brand.all
    Product.all
    respond_to do |format|
      format.html
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
    add_news_to_sitemap
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
          url: case_study_url(case_study),
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

  def add_news_to_sitemap
    @pages << { url: news_articles_url, updated_at: 1.day.ago, changefreq: 'daily', priority: 0.7 }
    NewsArticle.where("post_on <= ?", Date.today).each do |news|
      @pages << {
        url: news_article_url(news),
        updated_at: news.post_on.to_time,
        changefreq: 'monthly',
        priority: 0.5
      }
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
