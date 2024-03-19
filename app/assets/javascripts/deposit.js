
function hidePaymentForm() {
  var paymentForm = document.getElementById('paymentForm');
  paymentForm.style.display = 'none';
}

function showConfirmationForm() {
  var confirmationForm = document.getElementById('confirmationForm');
  confirmationForm.classList.remove('hidden-form');
}

document.addEventListener('DOMContentLoaded', function() {
  var makeDepositButton = document.getElementById('make_deposit_button');
  makeDepositButton.addEventListener('click', function() {
    hidePaymentForm();
    showConfirmationForm();
  });
});
