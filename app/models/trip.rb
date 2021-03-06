class Trip < ActiveRecord::Base
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers

  validates_presence_of :name, :lat, :lng, :mileage, :hiked_at, :nights

  has_pretty_param :name
  has_many    :photos
  has_many    :hearts
  has_many    :comments
  has_one     :gpx
  belongs_to  :user

  accepts_nested_attributes_for :photos, :allow_destroy => true

  after_save :update_user

  scope :year, lambda { |year|
    where(["hiked_at >= ? AND hiked_at <= ?", Date.civil(year,1,1), Date.civil(year,12,31)])
      .order("hiked_at DESC")
      .includes(:comments, :hearts, :user, :photos)
  }

  cattr_reader :per_page
  @@per_page = 15

  def self.algorithmic_sort
    # SCORE FORMULA: HEARTS + 1 DIVIDED BY THE NUMBER OF HOURS AGO
    trips = order("created_at DESC").limit(100).includes(:hearts, :user, :comments)
    trips.sort! {|a,b| b.score <=> a.score }
    trips[0..35]
  end

  def score
    @score ||= (hearts.size  + comments.size**0.25 + 1) / ((Time.now - created_at) / 3600)
  end

  def photos_array=(array)
    array.each { |photo| photos.build(image: photo) }
  end

  def to_bbcode
    output = ""
    output << "#{mileage} miles, #{elevation}' gained"
    output << ", #{nights} night(s)" if nights >0
    output << "\n\n#{report}\n\n"
    photos.each do |photo|
      unless photo.id.blank?
        output << "[url=http://wenthiking.com#{photo.image.url(:original)}][img]http://wenthiking.com#{photo.image.url(:large)}[/img][/url]"
        output << "\n#{photo.caption}" unless photo.caption.blank?
        output << "\n\n"
      end
    end
    output
  end

  def to_html
    output = ""
    output << "#{mileage} miles, #{elevation}' gained"
    output << ", #{nights} night(s)" if nights >0
    output << "\n\n#{report}\n\n"
    photos.each do |photo|
      unless photo.id.blank?
        output << link_to("<img src='http://wenthiking.com#{photo.image.url(:bpl)}' />".html_safe, "http://wenthiking.com#{photo.image.url(:original)}")
        output << "\n#{photo.caption}" unless photo.caption.blank?
        output << "\n\n"
      end
    end
    output
  end

  private

  def update_user
    user.update_stats
  end
end
