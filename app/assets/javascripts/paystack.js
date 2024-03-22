
document.addEventListener("DOMContentLoaded", function() {
  const paymentForm = document.getElementById('paymentForm');
  if (paymentForm) {
    paymentForm.addEventListener("submit", payWithPaystack);
  }
});

async function payWithPaystack(e) {
  e.preventDefault();


  const current_user = document.getElementById('paymentForm').getAttribute('data-current-user');
  let userEmail = "test@gmail.com";

  if (current_user) {
    try {
      const currentUserData = JSON.parse(current_user);
      if (currentUserData && currentUserData.email) {
        userEmail = currentUserData.email;
      }
    } catch (error) {
      console.error("Error parsing current user data:", error);
    }
  }

  const agreeAmountField = document.getElementById('agree_amount_input');
  const agreeAmountValue = agreeAmountField ? parseFloat(agreeAmountField.value) : null;

  if (agreeAmountValue === null || isNaN(agreeAmountValue)) {
    alert('Agreed amount is invalid!');
    return;
  }

  const paymentData = {
    key: 'pk_test_ff04215132a69e43478e07224af53fc56448028f',
    email: userEmail,
    amount: agreeAmountValue * 100,
    currency: 'ZAR',
    onClose: function() {
      triggerClassMethod();
      // Redirect to the create action in your Rails app
      window.location.href = "/susus/" + document.getElementById('paymentForm').getAttribute('data-susu-id') + "/deposits/new";
    },
    callback: function(response) {
      triggerClassMethod();
    }
  };

  try {
    const handler = await initializePaystack(paymentData);
    handler.openIframe();
  } catch (error) {
    console.error('Error initializing Paystack:', error);
  }
}

function initializePaystack(paymentData) {
  return new Promise((resolve, reject) => {
    const handler = PaystackPop.setup(paymentData);
    resolve(handler);
  });
}

function triggerClassMethod() {
  const paymentForm = document.getElementById('paymentForm');
  if (!paymentForm) {
    console.error('Payment form not found');
    return;
  }
  $.ajax({
    type: 'POST',
    url: `/susus/${paymentForm.getAttribute('data-susu-id')}/deposits`,
    data: $(paymentForm).serialize(),
    success: function(response) {
      console.log('Class method triggered:', response);
    },
    error: function(xhr, status, error) {
      console.error('Error triggering class method:', error);
    },
  });
}
