require 'nokogiri'
require 'open-uri'

# Start coding your hackernews scraper here!
class Post
  attr_reader :url, :doc, :title, :points, :item_id, :comments

  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(open(@url))
    @comments = []
    @doc.css(".comment").each do |x|
      @comments << Comment.new(
        comment: x.text.strip,
        user: x.parent.css(".hnuser").text,
        age: x.parent.css(".age").text.gsub(/[^0-9]/, "").to_i
      )
    end
    @title = @doc.css(".storylink").first.text
    @points = @doc.css(".score").first.text.gsub(/[^0-9]/, "").to_i
    @item_id = @doc.css(".score").first.values[1].gsub(/[^0-9]/, "")
  end

  def add_comment(comment)
    return unless comment.class == Comment
    @comments << comment
  end
end

class Comment
  attr_reader :comment, :user, :age
  def initialize(options={})
    @comment = options[:comment]
    @user = options[:user]
    @age = options[:age]
  end
end

# Driver Code
# my_post = Post.new("hn_scraper/post.html")
# p my_post.url
# p my_post.comments.first
# my_post.add_comment(Comment.new(comment: "Hello World", age: 0, user: "JustusFT"))
# p my_post.comments.last
