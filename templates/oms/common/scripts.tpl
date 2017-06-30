    <script src="/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
    <script src="/media/js/jquery-dateFormat-1.0.2.min.js" type="text/javascript"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <script type="text/javascript">{literal}
        var setHeightOfOuterContainerOfSidebar = function() {
            $('#sidebar-outer-container').height($(window).height());
        };
        $(setHeightOfOuterContainerOfSidebar);
        $(window).resize(setHeightOfOuterContainerOfSidebar);
    {/literal}</script>

    <script type="text/javascript">{literal}
        $('#select-site-type').change(function() {
            var selectedType = $(this).val();
            $('#sidebar').find('[data-role="site-entry"]').each(function() {
                var type = $(this).data('type');
                if (type == selectedType)
                    $(this).show();
                else
                    $(this).hide();
            });
        });
    {/literal}</script>