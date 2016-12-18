jQuery(function($) {
  $('#contact-form')
    .validator()
    .on('invalid.bs.validator', function (e) {
      var $error = $('#contact-error');
      errorMessageId = 'err-msg-' + e.relatedTarget.name
      $error.removeClass('hidden');
      $error.append('<p id="' + errorMessageId + '">' + e.detail + '</p>');
    })
    .on('valid.bs.validator', function (e) {
      $('#err-msg-' + e.relatedTarget.name).remove();
      $("#contact-error:empty").remove();
    })
    .on('submit', function(e) {
      if (e.isDefaultPrevented()) {
        return
      }

      var $form = $(this);
      var $target = $('#contact-header');
      var $container = $('#contact-body');
      var $error = $('#contact-error');

      $.ajax({
        type: $form.attr('method'),
        url: $form.attr('action'),
        data: $form.serialize(),
        error: function (xhr, ajaxOptions, thrownError) {
          $error.html(xhr.responseText);
          $error.removeClass('hidden');
        },
        success: function(data, status) {
          $target.html('Thanks for getting in touch! <span class="text-muted">We will get back to you soon to hear more about how we can help.</span>');
          $error.addClass('hidden');
          $container.hide();
        }
      });

      event.preventDefault();
    });
});
