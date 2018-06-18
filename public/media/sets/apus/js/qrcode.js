$(document).ready(function() {
    var $divs = $('[data-role="qrcode"]');
    var _default = {
        loadThumb: '1', //是否加载缩略图
        alpha: '1', //缩略图透明度
        url: "", //qrcode url
        width: "137px", //qrcode img width
        height: "137px", //qrcode img height
        padding: "10px 10px 10px 10px", //qrcode div padding
        thumbMargin: "",
        thumbPadding: "",
        thumbFloat: "none",
        left: "",
        top: "",
        txt: "", //文字
        animate: "slideDown", //support animate slideIn,slideDown
        border: "1px solid #d3d3d3", //默认边框
        thumb: {
            type: "",
            thumbUrl: "", //缩略图url
            thumbWidth: "",
            thumbHeight: "",
            thumbHoverUrl: "",
            thumbHoverWidth: "",
            thumbHoverHeight: "",
            thumbHoverPadding: ""
        },
        txtCss: {
            pos: "0", //文字位置 0:down 1:up
            gap: "0", //间距
            lineHeight: "18px",
            color: "#666666",
            fontSize: "12px",
            fontWeight: "normal",
            fontFamily: "微软雅黑",
            rowNum: "2" //默认两行文字
        }
    };
    var thumbConfig = {
        "1": { "size": "18px", "url": "../../../resource/pc/common/img/qrcode_type1.png" },
        "2": { "size": "24px", "url": "../../../resource/pc/common/img/qrcode_type2.png" },
        "3": { "size": "66px", "url": "../../../resource/pc/common/img/qrcode_type3.png" },
        "4": { "size": "24px", "url": "../../../resource/pc/common/img/qrcode_type4.png" }
    };
    var loading = "../../../resource/pc/common/img/loading.gif";
    var error = "../../../resource/pc/common/img/load_error.jpg";
    $divs.each(function() {
        var $this = $(this);
        var config = $this.data("config");
        if (typeof(config) != "object") {
            config = eval('(' + config + ')');
        }
        config["thumb"] = $.extend({}, _default["thumb"], config["thumb"]);
        config["txtCss"] = $.extend({}, _default["txtCss"], config["txtCss"]);
        config = $.extend({}, _default, config);
        var $thumb;
        var thumbUrl;
        var thumbWidth;
        var thumbHeight;
        var thumb;
        //thumb
        if (config["loadThumb"] == "1") { //add thumb
            thumb = config["thumb"];
            thumbUrl = thumb["thumbUrl"];
            if (!thumbUrl) {
                var type = thumb["type"];
                thumbUrl = thumbConfig[type]["url"];
                thumbWidth = thumbHeight = thumbConfig[type]["size"];
                $thumb = createThumb(thumbUrl, thumbWidth, thumbHeight);
            } else {
                thumbWidth = thumb["thumbWidth"];
                thumbHeight = thumb["thumbHeight"];
                $thumb = createThumb(thumbUrl, thumb["thumbWidth"], thumb["thumbHeight"]);
            }
            if (config["thumbPadding"] != "") {
                $thumb.css({ "padding": config["thumbPadding"] });
            }
            $thumb.css({ "opacity": config["alpha"] });
            $this.append($thumb);
            $this.css({ "width": $thumb.outerWidth(), "height": $thumb.outerHeight() });
        }
        $this.css({ "position": "relative", "margin": config["thumbMargin"], "float": config["thumbFloat"] });
        if (config["thumbMargin"] != "") {
            $this.css({ "margin": config["thumbMargin"] });
        }
        var url = config["url"];
        var txt = config["txt"];
        var pos = config["txtCss"]["pos"];
        //qrcode div
        var $childDiv = createQrDiv(config);
        //qrcode image
        var $childImg = createImg(loading);
        //text
        var $childTxt = createTxt(config);
        //text position support up and down
        if (pos == "0") {
            //down
            $childDiv.append($childImg);
            if (txt) {
                $childDiv.append($childTxt);
                $childTxt.css("margin-top", config["txtCss"]["gap"]);
            }
        } else {
            //up
            if (txt) {
                $childDiv.append($childTxt);
                $childTxt.css("margin-bottom", config["txtCss"]["gap"]);
            }
            $childDiv.append($childImg);
        }
        //add qrcode div
        $this.append($childDiv);
        //judge thumb is exist
        if ($this.find("[data-role='thumb_img']").length == 0) {
            //unregister event listener
            // $this.off("mouseover", onThubmMouseOver);
            // $this.off("mouseout", onThubmMouseOut);
            // $childDiv.off("mouseover", onQrcodeMouseOver);
            // $childDiv.off("mouseout", onQrcodeMouseOut);
            //show qrcode div
            loadImg(url, $childImg, config, error);
            txt = txt.replace(/#/g, "<br/>");
            $childTxt.html(txt);
            $childDiv.css({ "display": "block" });
            var imgHeight = parseInt(config["height"].replace("px", ""));
            $this.css({ "width": $childDiv.outerWidth(), "height": (imgHeight + $childTxt.height() + 5) });
        } else {
            //register event listener hover
            $this.hover(onThubmMouseOver, onThubmMouseOut);
        }

        //qrcode div relative to his parent offset
        //left right
        var offsetLeft = ($childDiv.outerWidth() - $this.width()) / 2;
        if (typeof(config["left"]) == "undefined" || config["left"] == "") {
            $childDiv.css("left", (-offsetLeft));
        } else {
            $childDiv.css("left", config["left"]);
        }
        //top bottom
        var offsetTop = $this.height() == $childDiv.height() ? 0 : $this.height();
        if (typeof(config["top"]) == "undefined" || config["top"] == "") {
            $childDiv.css("top", offsetTop);
        } else {
            $childDiv.css("top", config["top"]);
        }
        //thumb mouse over
        function onThubmMouseOver(e) {
            // mouseover change thumb image if hoverurl exist
            var hoverImg = thumb['thumbHoverUrl'];
            var width = thumb['thumbHoverWidth'];
            var height = thumb['thumbHoverHeight'];
            var padding = thumb['thumbHoverPadding'];
            if (typeof $thumb !== 'undefined' && !!hoverImg) {
                $thumb.attr({ 'src': hoverImg });
                width && $thumb.css({ 'width': width });
                height && $thumb.css({ 'height': height });
                padding && $thumb.css({ 'padding': padding });
            }
            // load qrcode image
            loadImg(url, $childImg, config, error);
            txt = txt.replace(/#/g, "<br/>");
            $childTxt.html(txt);

            //stop(stopAll,goToEnd)
            if (config["animate"] == "slideDown") {
                $childDiv.stop(true, false).slideDown(300);
            } else if (config["animate"] == "slideIn") {
                $childTxt.css({ "max-height": config["txtCss"]["rowNum"] * 18 });
                $childDiv.show();
                var offLeft = -1 * config["width"].replace(/px/, "") - $this.width() + (1 * config["left"].replace(/px/, ""));
                $childDiv.stop(true, false).animate({
                    opacity: "1",
                    left: offLeft,
                    width: config["width"],
                    padding: config["padding"]
                }, 300);
            }
        }
        //thumb mouse out
        function onThubmMouseOut(e) {
            // mouseout change thumb image default
            var hoverImg = thumb['thumbHoverUrl'];
            if (typeof $thumb !== 'undefined' && !!hoverImg) {
                $thumb.attr({ 'src': thumbUrl });
                $thumb.css({ 'width': thumbWidth, 'height': thumbHeight });
                config["thumbPadding"] && $thumb.css({ "padding": config["thumbPadding"] });
            }
            //隐藏
            if (config["animate"] == "slideDown") {
                $childDiv.stop(true, true).slideUp(300);
            } else if (config["animate"] == "slideIn") {
                $childTxt.css({ "max-height": config["txtCss"]["rowNum"] * 18 });
                $childDiv.stop(true, true).animate({
                    width: "0px",
                    padding: "0px",
                    left: "-200px"
                }, 300, function() {
                    $childTxt.css({ "max-height": "" });
                    $childDiv.css({ "opacity": "0", "left": config["left"] });
                    $childDiv.hide();
                });
            }
        }

    });
});

/**
 * load image
 */
var loadComplete = false;

function loadImg(url, qrImg, config, error) {
    //var img = new Image();
    //img.src = url;
    qrImg.attr("src", url);
    var num = 0;
    var timer = setInterval(function() {
        num++;
        if (loadComplete) {
            clearInterval(timer);
            timer = null;
        }
        if (num > 6) {
            qrImg.attr("src", error);
            clearInterval(timer);
            timer = null;
        }
    }, 500);

    qrImg[0].onload = function() {
        if (num < 3) {
            loadComplete = true;
            var qrWidth = config["width"];
            var qrHeight = config["height"];
            //qrImg.attr("src",img.src);
            qrImg.css({ "width": qrWidth, "height": qrHeight });
        }
    }
}
/**
 * thumb image
 */
function createThumb(url, width, height) {
    var $thumb = $('<img>');
    $thumb.attr({ "src": url, "data-role": "thumb_img", class: "thumb_img" });
    $thumb.css({ "width": width, "height": height, "border": "none" });
    return $thumb;
}

/**
 * qrcode div
 */
function createQrDiv(config) {
    var $childDiv = $('<div>');
    $childDiv.css({ "position": "absolute", "display": "none", "border": config["border"], "z-index": 9, "background-color": "#ffffff", "text-align": "center", "min-height": config["height"] });
    if (config["animate"] == "slideDown") {
        $childDiv.css({ "padding": config["padding"], "width": config["width"] });
    } else if (config["animate"] == "slideIn") {
        $childDiv.css({ "padding": "0px", "width": "0px", "opacity": "0" });
    }
    return $childDiv;
}

/**
 * qrcode img
 */
function createImg(loading) {
    var $childImg = $('<img>');
    $childImg.css({ "border": "none", "float": "none" });
    $childImg.attr("src", loading);
    return $childImg;
}

/**
 * qrcode text
 */
function createTxt(config) {
    var $childTxt = $('<div>');
    var txtCss = config["txtCss"];
    var divHeight = txtCss["rowNum"] * txtCss["lineHeight"].replace("px", "");
    $childTxt.css({ "font-size": txtCss["fontSize"], "color": txtCss["color"], "line-height": txtCss["lineHeight"], "fontWeight": txtCss["fontWeight"], "fontFamily": txtCss["fontFamily"], "width": "100%", "text-align": "center", "min-height": divHeight });
    return $childTxt;
}