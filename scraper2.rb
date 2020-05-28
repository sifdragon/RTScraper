require 'open-uri'
require 'nokogiri'


class Scraper

attr_reader :url, :movie
def initialize(movie)
 @movie = movie.capitalize
 @url = 'https://www.rottentomatoes.com/m/' + @movie
end

def movie=(value)
    @movie=value
    @url = 'https://www.rottentomatoes.com/m/' + @movie
end

def parse_url(url)
 unparsed_page = open(url)
 Nokogiri::HTML(unparsed_page)
end

def info
 parsed_page = parse_url(@url)
 critics_rating_section = parsed_page.css("div.mop-ratings-wrap__half")
 user_rating_section = parsed_page.css("div.mop-ratings-wrap__half.audience-score")
 synopsis = parsed_page.css("div#movieSynopsis.movie_synopsis.clamp.clamp-6.js-clamp").text.strip
 critics_rating = critics_rating_section.css('.mop-ratings-wrap__percentage').text.to_i
 user_rating = user_rating_section.css('.mop-ratings-wrap__percentage').text.to_i
 puts " #{@movie} synopsis: #{synopsis}" + "\n" + " Critics score: #{critics_rating}%" + "\n" + " User score: #{user_rating}%"
end


end