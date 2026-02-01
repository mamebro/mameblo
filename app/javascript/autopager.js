window.addEventListener('DOMContentLoaded', (event) => {
  var $container = $('.autopager-content');
  var $nextLink = $('.autopager-next');
  if ($container.length === 0 || $nextLink.length === 0) return;

  $container.infiniteScroll({
    path: '.autopager-next',
    append: '.autopager-item',
    hideNav: '.autopager-nav',
    scrollThreshold: 1000,
    prefill: true,
    status: '.page-load-status'
  });
});
