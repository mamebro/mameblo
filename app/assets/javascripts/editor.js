$(function() {
  var $entryForm = $('#new_entry'),
      $entryFormTitle = $entryForm.find('#entry-form-title'),
      $entryFormContent = $entryForm.find('#entry-form-content');

  $entryFormTitle
    .val(localStorage.getItem('entryFormTitle'));
  $entryFormContent
    .val(localStorage.getItem('entryFormContent'))
    .attr('data-rows-original', $entryFormContent.attr('rows'));

  $entryFormTitle.bind('keyup', function() {
    // 入力した文字を保存する
    localStorage.setItem('entryFormTitle', $(this).val());
  });

  $entryFormContent.bind('keyup', function() {
    var inputText = $(this).val();

    // 入力した文字数にあわせて textarea を広げる
    var self = this;
    var value = inputText.split('\n');
    var value_row = 0;
    $.each(value, function(i, val) {
      value_row += Math.max(Math.ceil(val.length/self.cols), 1);
    });
    var input_row = $(this).attr('rows');
    var original_row = $(this).attr('data-rows-original');
    var next_row = (input_row <= value_row) ? value_row + 1 : Math.max(value_row + 1, original_row);
    $(this).attr('rows', next_row);

    // 入力した文字を保存する
    localStorage.setItem('entryFormContent', inputText);

    // 日記を投稿できるかどうか調べる
    checkSubmittable();
  });

  $entryForm.submit(function() {
    clearLocalStorage();
  });

  $('.nav-editor-control').click(function() {
    var $body = $('body');
    if ($body.hasClass('is-editor')) {
      if ($entryForm.hasClass('submittable')) {
        if (window.confirm('投稿しなくて大丈夫？')) {
          clearLocalStorage();
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

  function clearLocalStorage() {
    localStorage.clear('entryFormTitle');
    localStorage.clear('entryFormContent');
    $entryFormTitle.val('');
    $entryFormContent.val('');
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
