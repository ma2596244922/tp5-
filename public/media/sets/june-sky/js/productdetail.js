$(document).ready(function() {
    var $image = $('.vertical-img').find('img');
    var $nextBtn = $('[data-role="next"]');
    var $prevBtn = $('[data-role="prev"]');
    var $thumbs = $('.pic-cont').find('a');
    var $current = $('.pic-cont').find('.cur-pic');
    var $nextPage = $('#pageNext');
    var $prevPage = $('#pagePrev');
    $nextBtn.on('click', function() {
        if (!$current.length) {
            if ($nextPage.length > 0) {
                location.href = $nextPage.attr('href');
            } else {
                $(this).addClass('js-end');
                $(this).attr({ 'title': '没有下一个' });
            }
            return;
        }
        var $next = $current.next();
        if ($prevBtn.hasClass('js-end')) {
            $prevBtn.attr({ 'title': '上一个' });
        }
        if ($next.length > 0) {
            $current.removeClass('cur-pic');
            $next.addClass('cur-pic');
            $current = $next;
            showCurrentImage($current.attr('picurl'));
        } else {
            if ($nextPage.length > 0) {
                location.href = $nextPage.attr('href');
            } else {
                $(this).addClass('js-end');
                $(this).attr({ 'title': '没有下一个' });
            }
        }
    });
    $prevBtn.on('click', function() {
        if (!$current.length) {
            if ($prevPage.length > 0) {
                location.href = $prevPage.attr('href');
            } else {
                $(this).addClass('js-end');
                $(this).attr({ 'title': '没有上一个' });
            }
            return;
        }
        var $prev = $current.prev();
        if ($nextBtn.hasClass('js-end')) {
            $nextBtn.attr({ 'title': '下一个' });
        }
        if ($prev.length > 0) {
            $current.removeClass('cur-pic');
            $prev.addClass('cur-pic');
            $current = $prev;
            showCurrentImage($current.attr('picurl'));
        } else {
            if ($prevPage.length > 0) {
                location.href = $prevPage.attr('href');
            } else {
                $(this).addClass('js-end');
                $(this).attr({ 'title': '没有上一个' });
            }
        }
    });
    $thumbs.on('click', function() {
        var $this = $(this);
        var $parent = $this.parent();
        if ($parent.hasClass('cur-pic')) {
            return;
        }
        $current.removeClass('cur-pic');
        $parent.addClass('cur-pic');
        $current = $parent;
        showCurrentImage($current.attr('picurl'));
    });

    function showCurrentImage(url) {
        var img = new Image();
        img.onload = function() {
            $image.attr('src', url).hide().fadeIn(300);
        }
        img.src = url;
    }
    // 只有一张图片是 居中
    if (!$('.pic-cont').length) {
        $('.js-box').css({
            'margin-top': '89px'
        });
    }
})