<?php
/**
 * 小站方法库测试
 *
 * @package timandes\crawler
 */

/**
 * enterprise.h.php
 *
 * @author 亚男
 */
class enterprisehTest extends PHPUnit_Framework_TestCase
{
    /**
     * function enterprise_extract_locale_n_domain()
     */
    public function test1()
    {
        // seamlesssteel-tube.com
        $host = 'www.seamlesssteel-tube.com';
        $expected = array('english', 'seamlesssteel-tube.com');
        $actual = enterprise_extract_locale_n_domain($host);
        $this->assertEquals($expected, $actual);

        $host = 'seamlesssteel-tube.com';
        $expected = array('', 'seamlesssteel-tube.com');
        $actual = enterprise_extract_locale_n_domain($host);
        $this->assertEquals($expected, $actual);

        $host = 'm.seamlesssteel-tube.com';
        $expected = array('english', 'seamlesssteel-tube.com');
        $actual = enterprise_extract_locale_n_domain($host);
        $this->assertEquals($expected, $actual);

        $host = 'french.seamlesssteel-tube.com';
        $expected = array('french', 'seamlesssteel-tube.com');
        $actual = enterprise_extract_locale_n_domain($host);
        $this->assertEquals($expected, $actual);

        // ltbtv.com.cn
        $host = 'www.ltbtv.com.cn';
        $expected = array('english', 'ltbtv.com.cn');
        $actual = enterprise_extract_locale_n_domain($host);
        $this->assertEquals($expected, $actual);

        $host = 'ltbtv.com.cn';
        $expected = array('', 'ltbtv.com.cn');
        $actual = enterprise_extract_locale_n_domain($host);
        $this->assertEquals($expected, $actual);

        $host = 'm.ltbtv.com.cn';
        $expected = array('english', 'ltbtv.com.cn');
        $actual = enterprise_extract_locale_n_domain($host);
        $this->assertEquals($expected, $actual);

        $host = 'french.ltbtv.com.cn';
        $expected = array('french', 'ltbtv.com.cn');
        $actual = enterprise_extract_locale_n_domain($host);
        $this->assertEquals($expected, $actual);
    }

    /**
     * function enterprise_pager_calculate_key_infos()
     */
    public function test2()
    {
        $total = 5;
        $size = 20;
        $cur = 1;
        $expected = array(
                'pages' => 1,
                'min_page' => 1,
                'max_page' => 1,
                'prev_page' => null,
                'next_page' => null,
                'first_page' => null,
                'last_page' => null,
            );
        $actual = enterprise_pager_calculate_key_infos($total, $size, $cur);
        $this->assertEquals($expected, $actual);

        $total = 501;
        $size = 20;
        $cur = 1;
        $expected = array(
                'pages' => 26,
                'min_page' => 1,
                'max_page' => 7,
                'prev_page' => null,
                'next_page' => 2,
                'first_page' => null,
                'last_page' => 26,
            );
        $actual = enterprise_pager_calculate_key_infos($total, $size, $cur);
        $this->assertEquals($expected, $actual);

        $total = 501;
        $size = 20;
        $cur = 15;
        $expected = array(
                'pages' => 26,
                'min_page' => 12,
                'max_page' => 18,
                'prev_page' => 14,
                'next_page' => 16,
                'first_page' => 1,
                'last_page' => 26,
            );
        $actual = enterprise_pager_calculate_key_infos($total, $size, $cur);
        $this->assertEquals($expected, $actual);
    }

    /**
     * function enterprise_admin_insert_keywords_to_value()
     */
    public function test3()
    {
        $keywords = array(
                'k1',
                'k2',
                'k3',
                'k4',
                'k5',
            );
        $value = 't1, t2, t3';
        //$expected = 'k1,t1,k2,t2,k3,t3,k4,k5';
        $expected = 't1,k1,t2,k2,t3,k3,k4,k5';
        $actual = enterprise_admin_insert_keywords_to_value($value, ',', $keywords, 5);
        $this->assertEquals($expected, $actual);

        $keywords = array(
                'k1',
                'k2',
                'k3',
                'k4',
                'k5',
            );
        $value = '576 shoots HIFU High Intensity Focused Ultrasound Liposunix fat loss equipment';
        //$expected = 'k1 576 k2 shoots k3 HIFU k4 High k5 Intensity Focused Ultrasound Liposunix fat loss equipment';
        $expected = '576 k1 shoots k2 HIFU k3 High k4 Intensity k5 Focused Ultrasound Liposunix fat loss equipment';
        $actual = enterprise_admin_insert_keywords_to_value($value, ' ', $keywords, 5);
        $this->assertEquals($expected, $actual);
    }
}