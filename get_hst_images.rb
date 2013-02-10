#!/usr/bin/env ruby

require 'mechanize'

agent = Mechanize.new

all = agent.get('http://hubblesite.org/gallery/album/entire/npp/all/')

puts "["
all.links.each do |link|
  next unless link.href
  next unless link.href.match(/^\/gallery\/album\/entire\/pr/)
  page = agent.get(link.href)
  page.links.each do |link|
    if link.text == 'Large'
      image_page = agent.get(link.href)
      image_page.search("img").each do |image|
        src = image.attributes['src'].value
        src.match(/\/([^\/]+)\-large_web.jpg/) do |md|
          puts "    '#{md[1]}',"
        end
      end
    end
  end
end

puts "]"
