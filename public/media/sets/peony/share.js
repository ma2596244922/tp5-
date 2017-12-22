$(function() {
    var openShareDialog = function(url) {
        window.open(url, '_blank', 'width=560,height=420,toolbar=no,resizable=no');
    };
    $('[data-role="share-btn-twitter"]').click(function() {
        var url = 'https://twitter.com/share?text=' + encodeURIComponent(document.title) + '&url=' + encodeURIComponent(location.href);
        openShareDialog(url);
    });
    $('[data-role="share-btn-pinterest"]').click(function() {
        var pic = $('img:eq(0)').attr('src');
        var url = 'http://www.pinterest.com/pin/create/button/?url=' + encodeURIComponent(location.href) + '&media=' + encodeURIComponent(pic) + '&description=' + encodeURIComponent(document.title);
        openShareDialog(url);
    });
    $('[data-role="share-btn-linkedin"]').click(function() {
        var url = 'https://www.linkedin.com/cws/share?url=' + encodeURIComponent(location.href) + '&token=&isFramed=true&lang=en_US';
        openShareDialog(url);
    });
    $('[data-role="share-btn-googleplus"]').click(function() {
        var url = 'https://plus.google.com/share?hl=en_US&url=' + encodeURIComponent(location.href);
        openShareDialog(url);
    });
});