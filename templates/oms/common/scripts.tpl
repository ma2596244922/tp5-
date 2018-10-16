    <script src="/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
    <script src="/media/js/jquery-dateFormat-1.0.2.min.js" type="text/javascript"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <script type="text/javascript">{literal}
        var setHeightOfOuterContainerOfSidebar = function() {
            $('#sidebar-outer-container').height($(window).height());
        };
        $(setHeightOfOuterContainerOfSidebar);
        $(window).resize(setHeightOfOuterContainerOfSidebar);
    {/literal}</script>

    <script type="text/javascript">{literal}
        var funFilterByType = function(selectedType) {
            var selectedType = $('#select-site-type').val();
            var type = $(this).data('type');
            if (type == selectedType)
                $(this).show();
            else
                $(this).hide();
        };
        var funShowLangSitesOnly = function() {
            var otherLangEnabled = $(this).data('other-lang-enabled');
            if (otherLangEnabled)
                $(this).show();
            else
                $(this).hide();
        };
        $('#select-site-type').change(function() {
            var selectedType = $(this).val();
            if (selectedType == 'lang_sites')
                var filterFunction = funShowLangSitesOnly;
            else
                var filterFunction = funFilterByType;
            $('#sidebar').find('[data-role="site-entry"]').each(filterFunction);
        });
    {/literal}</script>