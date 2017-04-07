require_relative "scraping_building_obj.rb"
my_post = Post.new(ARGV[0])
puts "Title: #{my_post.title}"
puts "#{my_post.comments.length} comments"
