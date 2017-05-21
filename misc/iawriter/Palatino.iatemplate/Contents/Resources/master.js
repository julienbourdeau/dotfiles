window.addEventListener('load', function() {
  
  var processMath = function() {
    var elements = document.body.getElementsByClassName('math')
    for (var i = 0, l = elements.length; i < l; i++) {
      var element = elements[i]
      var math = element.textContent
      var tex = TeXZilla.filterString(math)
      element.innerHTML = tex
    }
  }
  
  document.body.addEventListener('ia-writer-change', function() {
    processMath()
  })
})