<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

use think\Route;


/*根目录*/
Route::get('/','index/Index/home');
/*视图*/
Route::get('add_site','index/index/add_site');
Route::get('contact','index/index/contact');
Route::get('classify','index/index/classify');
Route::post('search','index/index/search');
Route::post('audit','index/index/audit');

/*后台*/
Route::get('online','index/admin/login');
Route::get('online/home','index/admin/home');
Route::get('online/home','admin/home');
Route::get('online/request','index/admin/request');
Route::get('online/judge','admin/request/judge');
Route::get('online/judge','index/admin/judge');
Route::get('online/add_site','admin/request/add_site');
Route::get('online/add_site','index/admin/add_site');
Route::get('online/disk','index/admin/disk');
Route::get('online/checked','index/admin/checked');
Route::get('online/grouping','index/admin/grouping');
Route::get('online/edit','index/admin/edit');
Route::get('online/add_grouping','index/admin/add_grouping');
Route::get('online/manage_grouping','index/admin/delete_grouping');
Route::get('online/waste','index/admin/waste');
Route::get('online/restore_url','index/admin/restore_url');
Route::get('online/restore_grouping','index/admin/restore_grouping');
Route::get('online/delete_request','index/admin/delete_request');
Route::post('online/verify','index/admin/verify');
Route::post('online/alter','index/admin/alter');
Route::post('online/add_manage','index/admin/add_manage');
Route::post('online/submit','index/admin/submit');
Route::post('online/submit_grouping','index/admin/submit_grouping');
Route::post('online/manage_grouping','index/admin/manage_grouping');












