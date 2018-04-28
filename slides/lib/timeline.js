(() => {
  const params = {};
  window.location.search.substring(1).split("&").forEach(pair => {
    params[pair.split("=")[0]] = pair.split("=")[1] || true
  });

  // usage: add ?start=2018-04-28T11:55&end=2018-04-28T12:10
  const timeline = document.getElementById('timeline')
  if(params.start && params.end && timeline) {
    const start = new Date(params.start);
    const period = new Date(params.end) - start;
    setInterval(() => {
      timeline.style.cssText = `left: ${(new Date() - start) * 100 / period}%;`;
    }, 1000);
  }
})();
