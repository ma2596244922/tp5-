/**
 * @dependancy cn.js,最低版本1.10
 *
 */
(function($) {
    /** @var int 验证方法计数器 */
    var validaterCounter = 0;
    /** 样式*/
    var styles = {focus:'',blur:''};

    /**
     * 内置验证方法
     */
    var innerValidaters = {
        /**
         * 值不能为空
         */
        noblank: function(options) {
            var value = this.val();
            value = $.trim(value);
            return !(value == "");
        },
        /**
         * 值的字符串长度介于M和N之间
         */
        text: function(options) {
            if (typeof(options['min']) == 'undefined') {
                options['min'] = 0;
            }

            var value = this.val();
            if(!value){return true;}
            return !(value.length > options['max'] || value.length < options['min'])
        },
        number: function(options) {
            var value = this.val();
            if(!value){return true;}
            value=chinacn.toDBCCase(value);
            var pattern=/^[0-9]+$/;
            return pattern.test(value);
        },
        floatnum: function(options) {
            var value = this.val();
            if(!value){return true;}
            value=chinacn.toDBCCase(value);
            var pattern=/^[\d]+$/;
            var pat =/^[\d]+\.[\d]+$/;
            return pattern.test(value) || pat.test(value);
        },
        cnchar: function(options) {
            var value = this.val();
            if(!value){return true;}
            var pat=/^[a-zA-Z]+[ a-zA-Z]+$/;
            var reg=/^[\u4E00-\u9FA5]+$/g;
            if(reg.test(value) || pat.test(value)){
                return true;
            }else{
                return false;
            }
        },
        greater_cn: function(options) {
            var value = this.val();
            var other = document.getElementById(options['otherCtr']);
            return (parseFloat(value) >= parseFloat(other.value));
        },
        lower_cn: function(options) {
            var value = this.val();
            var other = document.getElementById(options['otherCtr']);
            return (parseFloat(value) <= parseFloat(other.value));
        },
        greater_num: function(options) {
            if (typeof(options['min']) == 'undefined') {
                options['min'] = 0;
            }

            var value = this.val();
            if(!value){return true;}
            if (parseFloat(value)<options['min'] || parseFloat(value)>options['max']){
                return false;
            } else {
                return true;
            }
        },
        greater_str: function(options) {
            if (typeof(options['min']) == 'undefined') {
                options['min'] = '';
            }

            var value = this.val();
            if(!value){return true;}
            if (value<options['min'] || value>options['max']){
                return false;
            } else {
                return true;
            }
        },
        noendenglish: function(options) {
            var value = this.val();
            if(!value){return true;}
            value=chinacn.toDBCCase(value);
            var pattern = /^([0-9a-zA-Z_-]+)|([a-zA-Z0-9_-]+)$/i;
            return !pattern.test(value);
        },
        noendenglish2: function(options) {
            var value = this.val();
            if(!value){return true;}
            value=chinacn.toDBCCase(value);
            var pattern = /^([0-9_-]+)|([a-zA-Z0-9_-]+)$/i;
            return !pattern.test(value);
        },
        numberall: function(options) {
            var value = this.val();
            if(!value){return true;}
            var pattern = /^[0-9]+$/;
            return !pattern.test(value);
        },
        numberorfh: function(options) {
            var value = this.val();
            if(!value){return true;}
            var pattern = /^[0-9-]+$/;
            return pattern.test(value);
        },
        englistall: function(options) {
            var value = this.val();
            if(!value){return true;}
            var pattern = /^[a-zA-Z]+$/i;
            return !pattern.test(value);
        },
        specialcharacter: function(options) {
            var value = this.val();
            if(!value){return true;}
            value = $.trim(value);

            value = chinacn.toDBCCase(value);
            var pattern = /[\u0030-\u0039-]/; //0-9数字、-
            var result0 = pattern.test(value);
            var pattern = /[\u0041-\u005A]/; //大写字母
            var result1 = pattern.test(value);
            var pattern = /[\u0061-\u007A]/; //小写字母
            var result2 = pattern.test(value);

            var result3 = value.match(/[^\u3400-\u9FBB]/g);

            var pattern = /[\(\)\{\}\[\]]/;
            var result4 = pattern.test(value);
            var pattern = /\s/;
            var result5 = pattern.test(value);
            if ((result0 || result1 || result2 || result3 == null || result4) && !result5) {
                return true;
            }
            return false;
        },
        englishornumber: function(options) {
            var value = this.val();
            if(!value){return true;}
            var pattern = /^[a-zA-Z0-9]+$/i;
            return pattern.test(value);
        },
        checksubdomainisnan: function(options) {
            var value = this.val();
            if(!value){return true;}
            if(!isNaN(value) && value.length >=10){
                 return false;
            }
            return true;
        },
        nochinese: function(options) {
            var value = this.val();
            if(!value){return true;}
            var pattern = /[\u2500-\u9fa5]/;
            return !pattern.test(value);
        },
        chinese: function(options) {
            var value = this.val();
            if(!value){return true;}
            var pattern = /[\u2500-\u9fa5]/;
            return pattern.test(value);
        },
        sameas: function(options) {
            var value = this.val();
            var other = document.getElementById(options['otherCtr']);
            return ($.trim(other.value) == $.trim(value));
        },
        unsameas: function(options) {
            var value = this.val();
            var other = document.getElementById(options['otherCtr']);
            return !($.trim(other.value) == $.trim(value));
        },
        noequal: function(options) {
            var value = this.val();
            var other = document.getElementById(options['otherCtr']);
            return ($.trim(other.value) != value);
        },
        email: function(options) {
            var i, strDomain, cChar;
            var nDotCount = 0;
            var bFindAlpha = false;
            var bLastIsDot = false;
            var strValid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-.";
            var value = $.trim(this.val());

            if (value == "") return true;
            i = value.indexOf("@");
            if (i == -1 || i == 0 || i == value.length - 1) return false;
            strDomain = value.substring(i + 1, value.length);

            if (strDomain.indexOf("@") != -1) return false;
            if (strDomain.charAt(0) == ".") return false;
            if (strDomain.charAt(strDomain.length - 1) == ".") return false;
            for (i = 0; i < strDomain.length; i++) {
                cChar = strDomain.charAt(i);
                if (strValid.indexOf(cChar) == -1) return false;
                if (cChar == ".") {
                    if (bLastIsDot) return false;
                    bLastIsDot = true;
                    nDotCount++;
                } else bLastIsDot = false;
                if ((("a" <= cChar) && (cChar <= "z")) || (("A" <= cChar) && (cChar <= "Z")))
                    bFindAlpha = true;
            }
            if (bFindAlpha && (0 == nDotCount)) return false;
            var pa = /^[A-Za-z0-9]+([A-Za-z0-9-_.]+[A-Za-z0-9]+)*@([A-Za-z0-9]+[-.])+[A-Za-z0-9]{2,5}$/;
            // /^(?:\w+\.?)*-?\w+@(?:-?\w+\.?)*\w+$/;
            if (!pa.test(value)) {
                return false;
            }
            return true;
        },
        mobile: function(options) {
            var value = this.val();
            if(!value){return true;}
            var reg =  /^1[34578]\d{9}$/;
            return (reg.test(value));
        },
        chinamobile: function(options) {
            var value = this.val();
            if(!value){return true;}
            var area = $("#"+options['a']).val();
            if(area=='+86'){
                var reg =  /^1[34578]\d{9}$/;
            }else if(area=='+852'){  //  1/5/6/9开头的8、9或13位数字
                var reg = /^[1569](\d{7}|\d{8}|\d{12})$/;
            } else if (area == "+853") { //  6开头的8位数字
                var reg = /^[6]\d{7}$/;
            } else if (area == "+886") { // 6/7/9开头的8、9或11位数字
                var reg = /^[679](\d{7}|\d{8}|\d{10})$/;
            }
            return (reg.test(value));
        },
        checkboxinput: function(options) {
            var fg = 0;

            $("input[name='" + options['a'] + "'][type='checkbox']").each(function() {
                if ($(this).prop("checked")) {
                    fg = 1;
                }
            });
            if (fg > 0) return true;
            else return false;
        },
        radioinput: function(options) {
            var val = $("input[type='radio'][name='" + options['a'] + "']:checked").val();
            if (val == null) {
                return false;
            } else {
                return true;
            }
        },
        ajax: function(options) {
            var value = "";
            var param = "";
            var odata = options.data;
            for (i in odata) {
                if (odata[i] == 'text') {
                    param = param + i + "=" + $("#" + i).val() + "&";
                    value = $("#" + i).val();
                }
            }
            if(!value){return true;}
            var flag = false;
            $.ajax({
                type: "POST",
                url: "/manage.php?op=" + options.op,
                data: param + "r=" + Math.random(),
                async: false,
                dataType: "json",
                success: function(msg) {
                    if (msg.success == "1") {
                        flag = true;
                    } else {
                        flag = false;
                    }
                }
            });
            return flag;
        },
        ajaxnew: function(options) {
            var value = "";
            var param = "";
            var odata = options.data;
            for (i in odata) {
                if (odata[i] == 'text') {
                    param = param + i + "=" + $("#" + i).val() + "&";
                    value = $("#" + i).val();
                }
            }
            if(!value){return true;}
            var manage = $(this).data('ajaxManage') || {};
            if(typeof manage[options.op] == 'undefined'){
                manage[options.op] = {};
                $(this).data('ajaxManage',manage);
            }

            if(manage[options.op].value === value){
                return manage[options.op].state;
            }
            manage[options.op].value = value;
            manage[options.op].state = false;

            var flag = false;
            $.ajax({
                type: "POST",
                url: "/ajaxnew.php?op=" + options.op,
                data: param + "r=" + Math.random(),
                async: false,
                dataType: "json",
                success: function(msg) {
                    if (msg.success == "1") {
                        flag = true;
                        manage[options.op].state = true;
                    } else {
                        flag = false;
                    }
                }
            });
            return flag;
        },
        ajaxapi: function(options) {
            var value = "";
            var param = "";
            var odata = options.data;
            for (i in odata) {
                if (odata[i] == 'text') {
                    param = param + i + "=" + $("#" + i).val() + "&";
                    value = $("#" + i).val();
                }
            }
            if(!value){return true;}
            var flag = false;
            $.ajax({
                type: "POST",
                url: "/ajaxapi.php?op=" + options.op,
                data: param + "r=" + Math.random(),
                async: false,
                dataType: "json",
                success: function(msg) {
                    if (msg.success == "1") {
                        flag = true;
                    } else {
                        flag = false;
                    }
                }
            });
            return flag;
        },
        checkpwd: function(options) {
            var flag = false;
            var oldpwd = $("#oldpwd").val();
            var loginname = $("#loginname").val();
            $.ajax({
                type: "POST",
                url: "/ajaxnew.php?op=checkpwd",
                data: { oldpwd: oldpwd, loginname: loginname, r: Math.random() },
                async: false,
                dataType: "json",
                success: function(msg) {
                    if (msg.success == "1") {
                        flag = true;
                    } else {
                        flag = false;
                    }
                }
            });
            return flag;
        },
        third: function(options) {
            var value = this.val();
            value = $.trim(value);
            if (value.indexOf("?") != '-1') {
                strs = value.split("?")[1];
                var str = strs.substring(0, strs.indexOf('"'));
                var pattern = /^[0-9a-f]+$/;
                if (str.length && str.length == 32 && pattern.test(str)) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return false;
            }
        },
        /**
         * 自定义验证方法
         */
        custom: function(options) {
            return options['custom'].apply(this);
        }
    };

    /**
     * 针对选中项的操作
     */
    var itemMethods = {
        /**
         * 为选中项注册验证方法
         */
        register: function(group, options) {
            // append attribute
            var an = 'validation-group';
            this.attr(an, group);

            var ns = 'validaters.' + group + '.validation';

            // register handler to Event 'change'
            var eventNameSpace = 'change.events.validation';
            this.each(function() { // each object
                if ($(this).data(eventNameSpace) != 'on') {
                    var en = 'change.validation';
                    $(this).on(en, function() {
                        itemMethods.reset.apply($(this), [group]);
                    });
                    $(this).data(eventNameSpace, 'on');
                }
            });

            // get validaters
            var validaters = this.data(ns);
            if (typeof(validaters) == 'undefined')
                validaters = [];
            // append sequence no.
            options['no'] = ++validaterCounter;
            // append to validaters
            validaters.push(options)
                // save validaters
            return this.data(ns, validaters);
        },
        /**
         * 注销选中项的某个或全部验证方法
         */
        cancel: function(group, options) {
            var ns = 'validaters.' + group + '.validation';
            var an = 'validation-group';

            if (typeof(options) == 'undefined' || typeof(options['method']) == 'undefined') { // clear
                // remove validaters
                this.removeData(ns);
                // remove attribute
                this.removeAttr(an);
                return this;
            }

            // method
            var method = options['method'];

            // remove validater
            var validaters = this.data(ns);
            if (typeof(validaters) == 'undefined')
                validaters = [];
            var processedValidaters = [];
            for (var i in validaters) {
                if (typeof(validaters[i]['method']) == 'undefined')
                    continue;
                if (validaters[i]['method'] == method)
                    continue;
                processedValidaters.push(validaters[i]);
            }
            if (processedValidaters.length <= 0) {
                this.removeData(ns);
                // remove attribute
                var an = 'validation-group';
                this.removeAttr(an);
            } else
                this.data(ns, processedValidaters);

            return this;
        },
        /**
         * 验证选中项
         *
         * @return bool 通过验证返回true，否则返回false
         */
        validate: function(group) {
            var ns = 'validaters.' + group + '.validation';
            var retval = true;
            this.each(function() { // 依次验证每一个对象
                var validaters = $(this).data(ns);
                if (typeof(validaters) == 'undefined')
                    return;
                for (var i = 0; i < validaters.length; ++i) {
                    var validater = validaters[i];
                    if (typeof(validater['method']) == 'undefined')
                        continue;
                    if (typeof(innerValidaters[validater['method']]) == 'undefined')
                        continue;

                    var statusNS = 'status.validater' + validater['no'] + '.validaters.validation';
                    if ($(this).data(statusNS) == 'success')
                        continue;

                    if (!innerValidaters[validater['method']].apply($(this), [validater])) {
                        itemMethods.showFailureLayer.apply($(this), [group, validater]);
                        $(this).removeClass(styles['focus']).addClass(styles['blur']);
                        typeof validater['error'] != 'undefined' && validater['error'].apply(this);
                        retval = false;
                        return;
                    }
                    // save status 'success' to object
                    $(this).data(statusNS, 'success');
                }
                // callback 只会判断并调用最后注册的一项验证中是否有成功回调
                if (typeof(validater['success']) != 'undefined')
                    validater['success'].apply(this);
                // show layer
                itemMethods.showSuccessLayer.apply($(this), [group, validater]);
                $(this).removeClass(styles['blur']).removeClass(styles['focus']);
            });

            return retval;
        },
        getHintLayer: function(group, validater, type) {
            if (typeof(type) == 'undefined')
                $.error("Parameter type must be given.");

            switch (type) {
                case 'success':
                    var surfix = '_res';
                    break;
                case 'failure':
                    var surfix = '_info';
                    break;
                case 'tips':
                    var surfix = '_tips';
                    break;
                case 'animate':
                    var surfix = '_animate';
                    break;
                default:
                    $.error("Parameter type is ilegal.");
            }

            var id = this.attr('id');

            var roleName = type + '.validation';
            var possibleLayers = $('[for=' + id + '][role="' + roleName + '"]');
            if (possibleLayers.length > 0)
                return possibleLayers;

            var attrName = type + 'Layer';
            if (typeof(validater) != 'undefined' && typeof(validater[attrName]) != 'undefined')
                return $(validater[attrName]);

            var ns = type + '.' + group + '.validation';
            var possibleLayers = this.data(ns);
            if (typeof(possibleLayers) != 'undefined')
                return $(possibleLayers);

            return $('#' + id + surfix);
        },
        showHintLayer: function(group, validater, type) {
            var id = this.attr('id');
            if (typeof(id) == 'undefined')
                return;

            // find layers
            // 单个层,动画显示隐藏
            var animateLayer = itemMethods.getHintLayer.apply(this, [group, validater, 'animate']);
            // 多个层，切换显示隐藏
            var successLayer = itemMethods.getHintLayer.apply(this, [group, validater, 'success']);
            var failureLayer = itemMethods.getHintLayer.apply(this, [group, validater, 'failure']);
            var tipsLayer = itemMethods.getHintLayer.apply(this, [group, validater, 'tips']);

            if (animateLayer.length > 0 && successLayer.length == 0 && failureLayer.length == 0) {
                var className = validater['animate'];
                if (typeof type == 'undefined' || type == 'success') {
                    !!className && animateLayer.removeClass(className);
                } else {
                    var message = typeof validater === 'undefined' ? '' : validater['message'];
                    if (!message) {
                        animateLayer.removeClass(className);
                        return;
                    }
                    animateLayer.text(message).addClass(className);
                }
            } else {
                // layer operations
                tipsLayer.hide();
                if (typeof(type) == 'undefined' || type == 'success') {
                    successLayer.show();
                    failureLayer.hide();
                } else {
                    successLayer.hide();
                    var message = ((typeof(validater) != 'undefined') ? validater['message'] : '');
                    if (!message) {
                        failureLayer.hide();
                        return;
                    }
                    failureLayer.text(message);
                    failureLayer.show();
                }
            }
        },
        showSuccessLayer: function(group, validater) {
            itemMethods.showHintLayer.apply(this, [group, validater, 'success']);
        },
        showFailureLayer: function(group, validater) {
            itemMethods.showHintLayer.apply(this, [group, validater, 'failure']);
        },
        setSuccessLayer: function(group, layer) {
            var ns = 'success.' + group + '.validation';
            return this.data(ns, layer);
        },
        setFailureLayer: function(group, layer) {
            var ns = 'failure.' + group + '.validation';
            return this.data(ns, layer);
        },
        /**
         * 重置验证状态
         */
        reset: function(group) {
            var ns = 'validaters.' + group + '.validation';
            var validaters = this.data(ns);
            if (typeof(validaters) == 'undefined')
                return;
            for (var i = 0; i < validaters.length; ++i) {
                var validater = validaters[i];
                var statusNS = 'status.validater' + validater['no'] + '.validaters.validation';
                this.removeData(statusNS);
            }
        }
    };

    /**
     * 针对验证组的操作
     */
    var groupMethods = {
        /**
         * 注销验证组的某个或全部验证方法
         */
        cancel: function(group, options) {
            return $('[validation-group=' + group + ']').each(function() {
                $(this).validation('cancel.' + group);
            });
        },
        /**
         * “移出”验证组中的对象时立即验证
         */
        validateOnBlur: function(group) {
            return $('[validation-group=' + group + ']').on('blur.' + group + '.validation', function() {
                $(this).validation('validate.' + group);
            });
        },
        /**
         * 验证组中的全部对象
         */
        validate: function(group) {
            var retval = true;
            $('[validation-group=' + group + ']').each(function() {
                if (!$(this).validation('validate.' + group))
                    retval = false;
            });
            return retval;
        },
        /**
         * 验证表单对象添加样式
         */
        decorate: function(group, options) {
            styles = $.extend({}, styles, options);
            $('[validation-group=' + group + ']').on('focus.' + group + '.validation', function() {
                $(this).removeClass(styles['blur']).addClass(styles['focus']);
            });
        }
    };

    /**
     * 路由函数
     */
    var router = function(me, mapping, method, options) {
        var group = 'default';
        method = (typeof(method) == 'undefined') ? 'register' : method;
        options = (typeof(options) == 'undefined') ? {} : options;

        if (typeof(method) === 'string') {
            var nameChain = method.split('.');
            if (nameChain.length > 1) {
                method = nameChain[0];
                group = nameChain[1];
            }
        } else if (typeof(method) === 'object') {
            options = method;
            method = 'register';
        } else
            $.error('Method ' + method + ' does not exist on jQuery.validation');

        if (typeof(mapping[method]) != 'undefined')
            return mapping[method].apply(me, [group, options]);
        else
            $.error('Method ' + method + ' does not exist on jQuery.validation');
    };

    /**
     * 组操作
     */
    $.validation = function(method, options) {
        return router(this, groupMethods, method, options);
    };

    /**
     * 对象操作
     */
    $.fn.validation = function(method, options) {
        return router(this, itemMethods, method, options);
    };
})(jQuery);
