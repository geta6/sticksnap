($) ->
  $.fn.stickyel = (opt) ->
    subsets = []
    targets = 0
    defaults =
      prefix: 0
      target: '.title'

    options = $.extend defaults, opt

    for elem in ($ @)
      target = elem.find options.target
      subsets.push
        el: ($ elem)
        height: ($ elem).height()
        offset: ($ elem).offset.top
        banner:
          el: target
          height: target.height()

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

    return @
