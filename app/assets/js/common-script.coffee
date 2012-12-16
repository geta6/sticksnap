$ ->
  subsets = []
  targets = 0
  prefix = 51

  initialize = ->
    for div in ($ '.article')
      el = ($ div)
      banner = ($ div).find('.title')
      subsets.push
        el: el
        height: el.height()
        offset: el.offset().top
        banner:
          el: banner
          height: banner.height()

  initialize()

  ($ window).on 'scroll', (e) ->
    scroll = ($ @)[0].scrollY
    revise = ($ @)[0].innerHeight
    targets = -1
    for subset, i in subsets
      if subset.offset - prefix <= scroll
        target = subset
        targets = i
        target.banner.el.css
          position: 'absolute'
          bottom: '0px'
      else
        subset.banner.el.css
          position: 'absolute'
          bottom: subset.height - subset.banner.height + 'px'
    if target and scroll < target.offset + target.height - target.banner.height - prefix
        target.banner.el.css
          position: 'fixed'
          bottom: revise - target.banner.height - prefix + 'px'

  ($ '.next-post, .prev-post').on 'click', (event) ->
    if ($ event.target).hasClass 'next-post' then targets++ else targets--
    if targets < 0
      targets = 0
    else if targets > subsets.length - 1
      targets = subsets.length - 1
    ($ 'html, body').animate {scrollTop: subsets[targets].offset - prefix}, 240
