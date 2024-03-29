# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  FB.init(appId: '555819054450009', cookie: true)

  $('#sign_in').click (e) ->
    e.preventDefault()
    FB.login ((response) ->
      window.location = '/auth/facebook/callback' if response.authResponse),
      scope: "email,user_about_me,user_hometown,user_location,friends_about_me,friends_location,friends_hometown,read_friendlists"
     
  $('#sign_out').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true