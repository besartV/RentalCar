var rc  = (function() {
    return {
        modules: {}
    }
})();

rc.modules.home = (function() {
    return {
        init: function() {

        }
    }
})();

$(document).ready(function () {
    rc.modules.home.init();
});