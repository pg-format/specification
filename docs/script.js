document.addEventListener("DOMContentLoaded", function () {

  // Add "Try out" button on each PG format code example
  for (let pre of document.querySelectorAll("pre.sourceCode.pg")) {
    const btn = document.createElement('button')
    btn.className = "try-out-button"
    btn.title = "Try out"
    btn.innerHTML = '<i class="arrow-up-right-square"/>'
    btn.addEventListener("click", () => window.open(
      "https://pg-format.github.io/pg-formatter/?" +
      new URLSearchParams({pg: pre.innerText}) 
    ))
    pre.appendChild(btn)
  }

})
