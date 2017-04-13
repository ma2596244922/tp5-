var CustomValidate = (function() {
    var methods = {};
    var ajaxManage = {};
    /**
     * 验证cn或www下的验证码
     * @param  {[type]}
     * @return {[type]}
     */
    methods.captcha = function() {
        var value = $('#captcha').val();
        if (!value) {
            return true;
        }
        if (typeof ajaxManage['captcha'] === 'undefined') {
            ajaxManage['captcha'] = {};
        }

        if (ajaxManage['captcha'].value === value) {
            return ajaxManage['captcha'].state;
        }

        ajaxManage['captcha'].value = value;
        ajaxManage['captcha'].state = false;

        var flag = false;
        $.ajax({
            type: "GET",
            url: "/common/captcha/v2013/check.php",
            data: 'captcha=' + value + "&r=" + Math.random(),
            async: false,
            dataType: "json",
            success: function(msg) {
                if (msg.code === 0) {
                    flag = true;
                    ajaxManage['captcha'].state = true;
                } else {
                    flag = false;
                }
            }
        });
        return flag;
    };

    //调查问卷验证码
    methods.captcha2 = function() {
        var value = $('#captcha').val();
        if (!value) {
            return true;
        }
        if (typeof ajaxManage['captcha'] === 'undefined') {
            ajaxManage['captcha'] = {};
        }

        if (ajaxManage['captcha'].value === value) {
            return ajaxManage['captcha'].state;
        }

        ajaxManage['captcha'].value = value;
        ajaxManage['captcha'].state = false;

        var flag = false;
        $.ajax({
            type: "GET",
            url: "/program/captcha.php",
            data: 'act=chk&param=' + value + "&r=" + Math.random(),
            async: false,
            dataType: "json",
            success: function(msg) {
                if (msg.status == 'y') {
                    flag = true;
                    ajaxManage['captcha'].state = true;
                } else {
                    flag = false;
                }
            }
        });
        return flag;
    };
    /**
     * 验证18位省份证
     * @return {[type]} [description]
     */
    methods.idcard = function() {
        var flag = false;
        var value = $('#idcard').val();

        if (value.length === 18) {
            //权
            var power = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
            var pool = ['1', '0', 'x', '9', '8', '7', '6', '5', '4', '3', '2'];
            var parityBit = value.substr(17).toLowerCase();
            var sum = 0;
            var regExp = /[^0-9]+/;
            if (regExp.test(value.substr(0, 17))) {
                return false;
            }
            for (var i = 0; i < power.length; i++) {
                sum += (power[i] * parseInt(value.charAt(i)));
            }
            flag = (parityBit === pool[sum % 11]);
        }
        return flag;
    };


    return methods;
})();
