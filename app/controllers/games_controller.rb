require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ("A".."Z").to_a.sample }
  end

  def score
    @input = params[:words]
    @inputarray = @input.upcase.chars
    @message = ""
    url = "https://wagon-dictionary.herokuapp.com/#{@input}"
    check = URI.open(url).read
    outcome = JSON.parse(check)
    @found = outcome["found"]
    @hiddenletters = params[:letters]
    @fromthegrid = @inputarray.all? { |letter| @inputarray.count(letter) <= @hiddenletters.count(letter) }
    if !@fromthegrid
      @message = "Sorry but #{@input} cannot be built from
      #{@hiddenletters} 💔"
    elsif !@found
      @message = "not an english word"
    else
      @message = "well done"
    end
  end
end
