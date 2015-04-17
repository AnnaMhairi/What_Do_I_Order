class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # https://api.foursquare.com/v2/venues/40a55d80f964a52020f31ee3/tips?sort=recent&oauth_token=
  require 'httparty'

# venue_id = "40a55d80f964a52020f31ee3"
# KUINKNOWGLV0U2XU2BSHLG34BZTZPQGGPQDGERTYQFOAC11K

# response = HTTParty.get("https://api.foursquare.com/v2/venues/#{venue_id}/tips", query:{
#   sort: 'popular',
#   limit: 5,
#   client_id: "XFMFMCH3CTS0SLTMBQ2KDTFHVJFNPWEPIQU151PPJF5RUZAF",
#   client_secret: "NIIUDV3OY5UE5TGZBODQRPS351IVGW5532CV5E4QCQ1VU4CH",
#   v: 20150403})

# p response.body

# # client_id = "XFMFMCH3CTS0SLTMBQ2KDTFHVJFNPWEPIQU151PPJF5RUZAF"
# # client_secret = "NIIUDV3OY5UE5TGZBODQRPS351IVGW5532CV5E4QCQ1VU4CH"

class FourSquare
  include HTTParty
  base_uri 'https://api.foursquare.com/v2'

  def initialize
    @options = { query: {client_id: "XFMFMCH3CTS0SLTMBQ2KDTFHVJFNPWEPIQU151PPJF5RUZAF", client_secret: "NIIUDV3OY5UE5TGZBODQRPS351IVGW5532CV5E4QCQ1VU4CH", v:20150403} }
  end

  def search_restaurant(name)

  end

  def venue_tips(venue_id, options)
    new_options = {query: @options[:query].merge(options)}
    self.class.get("/venues/#{venue_id}/tips", new_options)
  end

  def venue_menu(venue_id)
    self.class.get("/venues/#{venue_id}/menu", @options)
  end

  def venue_search(venue, place)
    new_options= {query: @options[:query].merge({query: venue, near: place, section: 'food'})}
    self.class.get("/venues/search", new_options)
  end
end

# stack_exchange = StackExchange.new("stackoverflow", 1)
# puts stack_exchange.questions
# puts stack_exchange.users

foursquare = FourSquare.new

# p foursquare.venue_tips('40a55d80f964a52020f31ee3', {sort: 'popular', limit: 10})

# p foursquare.venue_menu('40a55d80f964a52020f31ee3')

results = foursquare.venue_search("Marlowe", "San Francisco, CA")
results["response"]["venues"].each{|venue| p venue["categories"][0]["name"] if venue["categories"][0]["name"].include?("Restaurant")}

# 4bf58dd8d48988d1c1941735
# 4bf58dd8d48988d12b951735
# 4bf58dd8d48988d157941735
end
