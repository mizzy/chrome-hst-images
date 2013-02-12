#!/usr/bin/env ruby

STDOUT.sync = true

require 'mechanize'

agent = Mechanize.new

page = agent.get('http://www.spacetelescope.org/images/viewall/')

puts '['

loop do
  table = page.search('table.archive_normal')[0]
  table.search('a').each do |link|
    link.attributes['href'].to_s.match(/^\/images\/(.+)\//) do |md|
      puts "    '#{md[1]}',"
    end
  end

  next_page = nil
  page.links.each do |link|
    next_page = link if link.text.match(/^Next/)
  end

  break unless next_page
  page = next_page.click
end

puts '];'
