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
  } else {
    console.error("Element with ID 'reload-link' not found!");
  }
});



const slider = document.getElementById("myRange");
const output = document.getElementById("sliderValue");
const fill = document.querySelector('.slider-fill');

// Update the span value and slider fill when the slider is moved
slider.addEventListener("input", function() {
    const value = parseInt(this.value);
    output.textContent = value;
    updateSliderFill();
});

// Function to update the slider fill based on the slider value
function updateSliderFill() {
    var percent = (slider.value - slider.min) / (slider.max - slider.min) * 100;
    fill.style.width = percent + '%';
}

document.getElementById("back_arrow").addEventListener("click", function(event) {
    event.preventDefault();
    window.location.href = "../";
});
