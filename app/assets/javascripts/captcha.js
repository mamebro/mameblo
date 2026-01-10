// Cap.js CAPTCHA integration
// https://capjs.js.org

(function() {
  'use strict';

  var CapCaptcha = {
    widget: null,

    init: function() {
      var widgetElement = document.querySelector('[data-cap-widget]');
      if (!widgetElement) return;

      var apiEndpoint = widgetElement.dataset.capApiEndpoint;
      if (!apiEndpoint) {
        console.error('Cap.js: API endpoint not configured');
        return;
      }

      this.loadCapWidget(apiEndpoint, widgetElement);
    },

    loadCapWidget: function(apiEndpoint, container) {
      var self = this;

      // Initialize Cap widget
      if (typeof Cap !== 'undefined') {
        self.initWidget(apiEndpoint, container);
      } else {
        // Cap.js is loaded via CDN in layout, wait for it
        var checkInterval = setInterval(function() {
          if (typeof Cap !== 'undefined') {
            clearInterval(checkInterval);
            self.initWidget(apiEndpoint, container);
          }
        }, 100);

        // Timeout after 5 seconds
        setTimeout(function() {
          clearInterval(checkInterval);
        }, 5000);
      }
    },

    initWidget: function(apiEndpoint, container) {
      var self = this;

      try {
        this.widget = new Cap({
          apiEndpoint: apiEndpoint,
          onStateChange: function(state) {
            self.handleStateChange(state);
          }
        });

        // Render the widget
        this.widget.render(container);

        // Listen for form submission
        this.bindFormSubmit(container);
      } catch (error) {
        console.error('Cap.js initialization error:', error);
      }
    },

    handleStateChange: function(state) {
      var tokenField = document.querySelector('[data-cap-token-field]');
      if (!tokenField) return;

      if (state.token) {
        tokenField.value = state.token;
      }
    },

    bindFormSubmit: function(container) {
      var self = this;
      var form = container.closest('form');
      if (!form) return;

      form.addEventListener('submit', function(event) {
        var tokenField = document.querySelector('[data-cap-token-field]');

        // If CAPTCHA is not yet solved, solve it first
        if (tokenField && !tokenField.value && self.widget) {
          event.preventDefault();

          self.widget.solve().then(function(token) {
            tokenField.value = token;
            form.submit();
          }).catch(function(error) {
            console.error('Cap.js solve error:', error);
            alert('CAPTCHA認証に失敗しました。ページを再読み込みしてください。');
          });
        }
      });
    }
  };

  // Initialize on DOM ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function() {
      CapCaptcha.init();
    });
  } else {
    CapCaptcha.init();
  }

  // Expose for debugging
  window.CapCaptcha = CapCaptcha;
})();
