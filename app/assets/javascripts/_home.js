$(document).ready(function() {
  var owner = $('#owner');
  var repository = $('#repository');
  var inputs = $('#owner, #repository');
  var feedLink = $('a.feed');
  var host = window.location.origin;
  var ENTER = 13;

  setUrl();

  inputs.on('input', function() {
    setUrl();
  });

  inputs.on('keyup', function(e) {
    if (e.keyCode !== ENTER) { return; }
    if (owner.val() !== '' && repository.val() !== '') {
      window.location.href = feedLink.attr('href');
    }
  });

  function setUrl() {
    var feedUrl = host + '/feeds/' + owner.val() + '/' + repository.val();
    feedLink.attr('href', feedUrl);
    feedLink.text(feedUrl);

    if (owner.val() !== '' || repository.val() !== '') {
      feedLink.removeClass('hidden');
    } else {
      feedLink.addClass('hidden');
    }
  }
});
