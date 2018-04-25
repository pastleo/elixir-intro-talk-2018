document.addEventListener("DOMContentLoaded", () => {
  let body = document.getElementsByTagName('body')[0];
  let spotlight = document.getElementById('spotlight');
  body.addEventListener('mousemove', (e) => {
    spotlight.style.cssText = `top: ${e.clientY}px; left: ${e.clientX}px;`;
  })
  body.addEventListener('keydown', (e) => {
    if(e.keyCode === 90) {
      spotlight.classList.add('enabled');
    }
  })
  body.addEventListener('keyup', (e) => {
    if(e.keyCode === 90) {
      spotlight.classList.remove('enabled');
    }
  })
})
