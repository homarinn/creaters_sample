$.fn.extend({
  hasClasses: function(selector) {
    if (typeof selector == "string") {
      selector = selector.match(/^\./)
        ? selector.replace(/^\./, "").split(".")
        : $.trim(selector).split(" ");
    }

    for (var i = 0, hit = 0, len = selector.length; i < len; i++) {
      if (this.hasClass(selector[i])) {
        hit++;
      }
    }

    return hit === len;
  }
});