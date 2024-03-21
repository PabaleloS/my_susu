document.addEventListener("DOMContentLoaded", function() {
  const hideIcon = document.getElementById("hideIcon");
  const actualBalance = document.getElementById("Actual_balance");
  const fakeBalance = document.getElementById("fake_balance");
  const secretBalanceDiv = document.getElementById("secret_balance");
  console.log('icon found')
  if (hideIcon) {
    hideIcon.addEventListener("click", function() {
      console.log('icon clicked', secretBalanceDiv.style.display === "inline")
      if (secretBalanceDiv.style.display === "inline") {
        secretBalanceDiv.style.display = "block";
        fakeBalance.style.display = "none";
        actualBalance.style.display = "inline";
      } else {
        secretBalanceDiv.style.display = "inline";
        fakeBalance.style.display = "inline";
        actualBalance.style.display = "none";
      }
    });
  }

});
