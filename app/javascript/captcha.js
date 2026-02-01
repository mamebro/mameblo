// Cap.js CAPTCHA integration
// https://capjs.js.org

(function() {
  'use strict';

  function initCaptcha() {
    var widget = document.querySelector('cap-widget');
    if (!widget) return;

    var tokenField = document.getElementById('captcha-token');
    if (!tokenField) return;

    // Listen for solve event to capture token
    widget.addEventListener('solve', function(event) {
      tokenField.value = event.detail.token;
    });

    // Listen for error event
    widget.addEventListener('error', function(event) {
      console.error('Cap.js error:', event.detail);
    });
  }

  // Initialize on DOM ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCaptcha);
  } else {
    initCaptcha();
  }
})();
