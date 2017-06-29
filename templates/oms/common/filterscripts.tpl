    <script type="text/javascript">{literal}
        var submitToDate = function(from, to) {
            $('#inputFrom').val(from);
            $('#inputTo').val(to);
            $('#formFilter').submit();
        };
        var getDaysOfMonth = function(dt) {
            var m = dt.getMonth() + 1;
            switch (m) {
                case 1:
                case 3:
                case 5:
                case 7:
                case 8:
                case 10:
                case 12:
                    return 31;
                case 4:
                case 6:
                case 9:
                case 11:
                    return 30;
            }

            var y = dt.getFullYear();
            if ((y % 4 == 0
                    && y % 100 != 0)
                    || y % 400 == 0)
                return 29;
            else
                return 28;
        };
        $('#btnToday').click(function() {
            var now = $.format.date(new Date(), 'yyyy-MM-dd');
            submitToDate(now, now);
        });
        $('#btnYesterday').click(function() {
            var now = $.format.date(new Date(), 'yyyy-MM-dd');
            var ts = Date.parse(now);
            ts -= 1000 * 86400;

            var yesterday = $.format.date(new Date(ts), 'yyyy-MM-dd');
            submitToDate(yesterday, yesterday);
        });
        $('#btnRecent7Days').click(function() {
            var now = $.format.date(new Date(), 'yyyy-MM-dd');
            var tsTo = Date.parse(now);
            var tsFrom = tsTo - 1000 * 86400 * 7;

            var to = $.format.date(new Date(tsTo), 'yyyy-MM-dd');
            var from = $.format.date(new Date(tsFrom), 'yyyy-MM-dd');
            submitToDate(from, to);
        });
        $('#btnRecent30Days').click(function() {
            var now = $.format.date(new Date(), 'yyyy-MM-dd');
            var tsTo = Date.parse(now);
            var tsFrom = tsTo - 1000 * 86400 * 30;

            var to = $.format.date(new Date(tsTo), 'yyyy-MM-dd');
            var from = $.format.date(new Date(tsFrom), 'yyyy-MM-dd');
            submitToDate(from, to);
        });
        $('#btnThisMonth').click(function() {
            var dt = new Date();
            var from = $.format.date(dt, 'yyyy-MM-01');
            var ts = Date.parse(from);
            ts += (getDaysOfMonth(dt) - 1) * 86400 * 1000;

            var dtLastDayOfThisMonth = new Date(ts);
            var to = $.format.date(dtLastDayOfThisMonth, 'yyyy-MM-dd');
            submitToDate(from, to);
        });
        $('#btnLastMonth').click(function() {
            var dt = new Date();
            var firstDay = $.format.date(dt, 'yyyy-MM-01');
            var ts = Date.parse(firstDay);
            ts -= 1000 * 86400;

            var dtLastDayOfLastMonth = new Date(ts);
            var from = $.format.date(dtLastDayOfLastMonth, 'yyyy-MM-01');
            var to = $.format.date(dtLastDayOfLastMonth, 'yyyy-MM-dd');
            submitToDate(from, to);
        });
    {/literal}</script>