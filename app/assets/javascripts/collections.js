$(document).ready(function() {
    $('.load-comments').click(function() {
        if ($('#comments').find('.comment').length > 0) {
           $('#comments').slideToggle();
            return false;
        }
    });
});