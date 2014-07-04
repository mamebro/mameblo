$(function() {
  var $entryForm = $('#new_entry'),
      $entryFormTitle = $entryForm.find('#entry-form-title'),
      $entryFormContent = $entryForm.find('#entry-form-content');

  $entryFormTitle
    .val(localStorage.getItem('entryFormTitle'));
  $entryFormContent
    .val(localStorage.getItem('entryFormContent'))
    .attr('data-rows-original', $entryFormContent.attr('rows'));

  checkSubmittable();

  $('textarea').autosize();

  $entryFormTitle.bind('keyup', function() {
    // 入力した文字を保存する
    localStorage.setItem('entryFormTitle', $(this).val());
  });

  $entryFormContent.bind('keyup', function() {
    // 入力した文字を保存する
    localStorage.setItem('entryFormContent', $(this).val());
    // 日記を投稿できるかどうか調べる
    checkSubmittable();
  });

  $entryForm.submit(function() {
    clearDraft();
  });

  $('.nav-editor-control').click(function() {
    var $body = $('body');
    if ($body.hasClass('is-editor')) {
      if ($entryForm.hasClass('submittable')) {
        if (window.confirm('投稿しなくて大丈夫？')) {
          clearDraft();
          $entryFormTitle.val('');
          $entryFormContent.val('');
          $body.removeClass('is-editor');
        }
      } else {
        $body.removeClass('is-editor');
      }
    } else {
      $body.addClass('is-editor');
    }
  });

  $entryForm.find('textarea').focus(function () {
    if (!$(this).hasClass('focus')) {
      $(this).addClass('focus');
    }
    $(window).keydown(function (e) {
      if (e.metaKey && e.keyCode === 13) {
        $entryForm.submit();
      }
    });
    checkSubmittable();
  });

  function clearDraft() {
    localStorage.clear('entryFormTitle');
    localStorage.clear('entryFormContent');
  }

  function checkSubmittable() {
    if ($entryFormContent.val().replace(/\s/g, '').length > 0) {
      if (!$entryForm.hasClass('submittable')) {
        $entryForm.addClass('submittable');
        $('#entry-form-submit').fadeIn(250);
      }
    } else {
      if ($entryForm.hasClass('submittable')) {
        $entryForm.removeClass('submittable');
        $('#entry-form-submit').fadeOut(250);
      }
    }
  }
});
