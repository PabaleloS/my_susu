
function hidePaymentForm() {
  const paymentForm = document.getElementById('paymentForm');
  paymentForm.style.display = 'none';
}

function showConfirmationForm() {
  const confirmationForm = document.getElementById('confirmationForm');
  confirmationForm.classList.remove('hidden-form');
}

document.addEventListener('DOMContentLoaded', function() {
  const makeDepositButton = document.getElementById('make_deposit_button');
  if (makeDepositButton) {
    makeDepositButton.addEventListener('click', function() {
      hidePaymentForm();
      showConfirmationForm();
    });
  }
});
