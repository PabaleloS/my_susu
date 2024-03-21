
document.addEventListener("DOMContentLoaded", function() {
  const reloadLink = document.getElementById("reload-link");

  if (reloadLink) {
    reloadLink.addEventListener("click", function(event) {
      event.preventDefault();
      window.location.href = reloadLink.href;


      if (window.Turbolinks) {
        Turbolinks.visit(reloadLink.href, { action: "replace" });
      }

      console.log("Reload Button Clicked!");
    });
  }



  const backArrow = document.getElementById("back_arrow")

  if (backArrow) {
    backArrow.addEventListener("click", function(event) {
      event.preventDefault();
      window.location.href = "../";
    });
  }
});
