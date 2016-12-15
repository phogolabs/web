function hasHtml5Validation () {
 return typeof document.createElement('input').checkValidity === 'function';
}

if (hasHtml5Validation()) {
 $('form').submit(function (e) {
   if (!this.checkValidity()) {
     $(this).addClass('invalid');
     e.preventDefault();
   } else {
     $(this).removeClass('invalid');
   }
 });
}
