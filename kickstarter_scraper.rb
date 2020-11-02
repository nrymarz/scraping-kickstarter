require 'nokogiri'
require 'open-uri'
require 'pry'
def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2").css("strong").text.strip.to_sym
    projects[title] = {}
    projects[title][:image_link] = project.css('img').attribute("src").value
    projects[title][:description] = project.css("p.bbcard_blurb").text.strip
    projects[title][:location] = project.css("span.location-name").text
    projects[title][:percent_funded] = project.css("li.first.funded strong").text.to_i
  end
  projects
end

