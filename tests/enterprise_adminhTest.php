<?php
/**
 * 小站方法库测试
 *
 * @package timandes\crawler
 */

/**
 * enterprise_admin.h.php
 *
 * @author 亚男
 */
class enterprise_adminhTest extends PHPUnit_Framework_TestCase
{
    /**
     * function enterprise_admin_insert_keywords_to_value()
     */
    public function test1()
    {
        $value = '1 2 3';
        $separator = ' ';
        $targetKeywords = ['a'];
        $targetCnt = count($targetKeywords);
        $expected = '1 a 2 3';
        $actual = enterprise_admin_insert_keywords_to_value($value, $separator, $targetKeywords, $targetCnt);
        $this->assertEquals($expected, $actual);

        $targetKeywords = ['a', 'b', 'c', 'd'];
        $targetCnt = count($targetKeywords);
        $expected = '1 a 2 b 3 c d';
        $actual = enterprise_admin_insert_keywords_to_value($value, $separator, $targetKeywords, $targetCnt);
        $this->assertEquals($expected, $actual);
    }

    /**
     * function enterprise_admin_insert_keywords_to_value(reverse)
     */
    public function test2()
    {
        $value = '1 2 3';
        $separator = ' ';
        $targetKeywords = ['a'];
        $targetCnt = count($targetKeywords);
        $expected = '1 2 a 3';
        $actual = enterprise_admin_insert_keywords_to_value($value, $separator, $targetKeywords, $targetCnt, true);
        $this->assertEquals($expected, $actual);

        $targetKeywords = ['a', 'b', 'c', 'd'];
        $targetCnt = count($targetKeywords);
        $expected = 'd c 1 b 2 a 3';
        $actual = enterprise_admin_insert_keywords_to_value($value, $separator, $targetKeywords, $targetCnt, true);
        $this->assertEquals($expected, $actual);
    }
}