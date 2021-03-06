require 'tree_positioning'
require 'tree_navigation'

class DocumentationPage < ActiveRecord::Base
  xapor do |idx|
    idx.search :title, :store => true
    idx.search :content, :store => true
  end

  has_many :comments

  validates_presence_of :title, :content
  has_friendly_id :title, :use_slug => true
  acts_as_tree :order => 'position ASC'

  def content
    
    read_attribute(:content).try(:sanitize)
  end

  before_save :generate_toc

  include TreePositioning
  include TreeNavigation

  def has_parent?
    self.parent_id?
  end

  def self.update_tree(new_tree)
    skip_collisions do
      @pages = all
      if new_tree[:documentation_page]
        new_tree[:documentation_page].each do |id, new_values|
          current = @pages.find {|p| p.friendly_id == id}
          current.update_attributes(new_values) if current
        end
      end
    end
  end

  def generate_toc
    doc = Nokogiri::HTML(self.content)
    toc_items = doc.css("h2").map {|h2| "<li><a href=\"##{h2.text.snake_case}\">#{h2.text}</a></li>"}
    self.toc = toc_items.empty? ? "" : "<ul>#{toc_items.join("")}</ul>"
  end
end
