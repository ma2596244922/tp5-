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
}