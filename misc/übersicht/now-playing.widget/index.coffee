options =
  # Enable or disable the widget.
  widgetEnable : true                   # true | false

  # Choose where the widget should sit on your screen.
  verticalPosition    : "bottom"        # top | bottom | center
  horizontalPosition    : "left"        # left | right | center

command: "osascript 'now-playing.widget/lib/Get Current Track.applescript'"
refreshFrequency: '1s'
style: """

// setup
// --------------------------------------------------
display: none
font-family system, -apple-system, "Helvetica Neue"
font-size: 10px
margin = 10px
position: absolute

// variables
// --------------------------------------------------
widgetWidth 300px
borderRadius 6px
infoHeight 72px
infoWidth @widgetWidth - 82

// screen positioning calculations
// --------------------------------------------------
if #{options.verticalPosition} == center
    top 50%
    transform translateY(-50%)
else
    #{options.verticalPosition} margin

if #{options.horizontalPosition} == center
    left 50%
    transform translateX(-50%)
else
    #{options.horizontalPosition} margin

// styles
// --------------------------------------------------
.container
    width: @widgetWidth
    height: @infoHeight
    text-align: left
    position: relative
    clear: both
    color #fff
    background rgba(#000, .5)
    padding 10px
    border-radius @borderRadius

.album-art
    width: @infoHeight
    height: @width
    border-radius @borderRadius
    background-image: url(now-playing.widget/lib/default.png)
    background-size: cover
    float: left

.track-info
    width: @infoWidth
    height: @infoHeight
    margin-left: 10px
    position: relative
    float: left

.artist-name
    font-weight: bold
    text-transform: uppercase
    margin-top: 3px
    margin-bottom: 5px
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis

.track-title
    font-size: 14px
    text-transform: uppercase
    margin-bottom: 5px
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis

.album-title
    font-weight: bold
    text-transform: uppercase
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis

.bar-container
    width: 100%
    height: @borderRadius
    border-radius: @borderRadius
    background: rgba(#fff, .5)
    position: absolute
    bottom: 4px

.bar
    height: @borderRadius
    border-radius: @borderRadius
    transition: width .2s ease-in-out

.bar-progress
    background: rgba(#fff, .85)
"""

options : options

render: () -> """
<div class="container">
    <div class="album-art"></div>
    <div class="track-info">
        <div class="artist-name"></div>
        <div class="track-title">title</div>
        <div class="album-title"></div>
        <div class="bar-container">
            <div class="bar bar-progress"></div>
        </div>
        <div class="console">
        </div>
    </div>
</div>
"""

# Update the rendered output.
update: (output, domEl) ->

  div = $(domEl)

  if @options.widgetEnable

    if !output
      div.animate({opacity: 0}, 250, 'swing').hide(1)
    else
      values = output.slice(0,-1).split(" @ ")
      div.find('.artist-name').html(values[0])
      div.find('.track-title').html(values[1])
      div.find('.album-title').html(values[2])
      tDuration = values[3]
      tPosition = values[4]
      tArtwork = values[5]
      songChanged = values[6]
      currArt = "/" + div.find('.album-art').css('background-image').split('/').slice(-3).join().replace(/\,/g, '/').slice(0,-1)
      tWidth = 218
      tCurrent = (tPosition / tDuration) * tWidth
      div.find('.bar-progress').css width: tCurrent
      div.show(1).animate({opacity: 1}, 250, 'swing')

      if currArt isnt tArtwork and tArtwork isnt 'NA'
        artwork = div.find('.album-art')
        artwork.css('background-image', 'url('+tArtwork+')')
      else if tArtwork is 'NA'
        artwork = div.find('.album-art')
        artwork.css('background-image', 'url(now-playing.widget/lib/default.png)')
  else
    div.hide()
