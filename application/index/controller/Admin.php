<?php
/**
 * Created by PhpStorm.
 * User: EDZ
 * Date: 2018/9/25
 * Time: 11:41
 */

namespace app\index\controller;
use think\Db;
use think\Controller;
use think\Request;
use think\Session;
class Admin extends Controller
{
    //登录页面
    public function login()
    {
        return view('admin/login/index');
    }
    //验证登录密码
    public  function verify()
    {
        $user     = input('post.user');
        $password = input('post.password');
        $password = md5($password);
        $login['account']     = $user;
        $login['password']    = $password;
        $login['permissions'] = 1;
        if($user !="" && $password !=""){
            $data = db('admin_login')->where($login)->select();
            //根据查询结果跳转
            if($data){
                Session::set('name',$user,'think');
                Session::set('password',$password,'think');
                $this->assign('data',$data);
                $this->success('登录成功', 'admin/home');
            }else{
                $this->error('账号或者密码错误');
            }
        }else{
            $this->error('对不起,未输入账号或者密码');
        }
    }
    public function home()
    {
        $session = Session::has('name','think');
        if($session ==true){
            return view('admin/home');
        }else {
            return view('admin/login/index');
        }

    }
    //修改密码
    public function alter()
    {
        $user     = input('post.user');
        $password = input('post.password');
        $password = md5($password);
        $login['account']     = $user;
        $login['password']    = $password;
        $login['permissions'] = 1;
        if($user !="" && $password !="") {
            $data = db('admin_login')->where($login)->select();
            if ($data) {
                $this->error('对不起,您未修改过账号或者密码');
            } else {
                $data = db('admin_login')->where('id', 1)->update(['account' => $user, 'password' => $password]);
                Session::set('name',$user,'think');
                Session::set('password',$password,'think');
                $this->success('修改成功', 'admin/home');
            }
        }else{
            $this->error('对不起,未输入你要修改之后的账号或者密码');
        }
    }
    //审核列表
    public function request()
    {
        $session = Session::has('name','think');
        if($session ==true) {
            $data = Db::view('admin_audit','id,name,site,judge')
                ->view('admin_type','type,state','admin_type.id=admin_audit.type_id')
                ->where('admin_audit.judge=1')->where('admin_type.state=0')->order('id desc')->paginate(15);
            $this->assign('data', $data);
            return view('admin/request/index');
        }else{
            return view('admin/login/index');
        }
    }
    //单个详细审核页
    public function judge()
    {
        $session = Session::has('name','think');
        if($session ==true) {
            $id = Request::instance()->param('id');

            $data = Db::view('admin_audit','id,name,site,judge')
                ->view('admin_type','type','admin_type.id=admin_audit.type_id')
                ->where('id',$id)->select();
            $type = Db::table('admin_type')->where('state','0')->select();
            if($data && $type){
                $this->assign('type',$type);
                $this->assign('data',$data);
            return view('admin/request/judge');
            }else{
                $this->error('对不起,未找到该信息,请稍后再试');
            }
        }else{
            return view('admin/login/index');
        }
    }
    //提交审核
    public function submit()
    {
        $name     = input('post.name');
        $site     = input('post.site');
        $id       = input('post.id');
        $category = input('post.category');
        $judge    = input('post.checked');
        if($name !="" &&$site !=""){
            $data = db('admin_audit')->where('id', $id)->update(['name' => $name, 'site' => $site,'type_id'=>$category,'judge'=>$judge]);
            if($data){
                $this->success('操作成功', 'index/admin/request');
            }else {
                $this->error('对不起,审核失败,请稍后再试');
            }
        }else{
            $this->error('对不起,网站名称或者网站地址没有填写');
        }
    }
    //删除网站信息
    public function delete_request()
    {
        $session = Session::has('name','think');
        if($session ==true) {
            $id = Request::instance()->param('id');
            $data = db('admin_audit')->where('id', $id)->update(['state' => '1']);

            if($data){
                $this->success('删除成功', 'index/admin/request');
            }else {
                $this->error('对不起,删除失败,请稍后再试');
            }
        }else{
            return view('admin/login/index');
        }
    }
    //已审核
    public function checked()
    {
        $session = Session::has('name','think');
        if($session ==true) {
            $data = Db::view('admin_audit','id,name,site,judge')
                ->view('admin_type','type','admin_type.id=admin_audit.type_id')
                ->where('admin_audit.judge=0')->where('admin_type.state=0')->order('id desc')->paginate(15);
            $type = Db::table('admin_type')->select();
            $this->assign('type', $type);
            $this->assign('data', $data);
            return view('admin/checked/index');
        }else{
            return view('admin/login/index');
        }
    }
    //添加分组
    public function add_grouping()
    {
        $session = Session::has('name','think');
        if($session ==true) {
            $type = Db::table('admin_type')->select();
            $this->assign('type',$type);
            return view('admin/grouping/add_grouping');
        }else{
            return view('admin/login/index');
        }
    }
    //处理添加分组
    public function manage_grouping()
    {
        $name     = input('post.name');
        if($name !=""){
            $data = ['type' => $name,'state'=>0];
            Db::table('admin_type')->insert($data);
            $this->success('添加成功', 'index/admin/grouping');
        }else{
            $this->error('对不起分组名称没有填写');
        }
    }
    //分组管理
    public function grouping()
    {
        $session = Session::has('name','think');
        if($session ==true) {
            $type = Db::table('admin_type')->where('state',0)->select();
            $this->assign('type', $type);
            return view('admin/grouping/index');
        }else{
            return view('admin/login/index');
        }
    }
    //编辑分组
    public function edit()
    {
        $session = Session::has('name','think');
        if($session ==true) {
            $id = Request::instance()->param('id');
            $type = Db::table('admin_type')->where('id',$id)->select();
            $this->assign('type', $type);
            return view('admin/grouping/edit');
        }else{
            return view('admin/login/index');
        }
    }
    //处理分组信息
    public function submit_grouping()
    {
        $name     = input('post.name');
        $id       = input('post.id');
        if($name !=""){
            $data = db('admin_type')->where('id', $id)->update(['type' => $name]);
            if($data){
                $this->success('修改成功', 'index/admin/grouping');
            }else {
                $this->error('对不起,修改失败,请稍后再试');
            }
        }else{
            $this->error('对不起,分组名称没有填写');
        }
    }
    //删除分组信息
    public function delete_grouping()
    {
        $session = Session::has('name','think');
        if($session ==true) {
            $id = Request::instance()->param('id');
            $data = db('admin_type')->where('id', $id)->update(['state' => '1']);

            if($data){
                $this->success('删除成功', 'index/admin/grouping');
            }else {
                $this->error('对不起,删除失败,请稍后再试');
            }
        }else{
            return view('admin/login/index');
        }
    }
    //添加新网址
    public function add_site()
    {
        $session = Session::has('name','think');
        if($session ==true) {
            $type = Db::table('admin_type')->where('state',0)->select();
            $this->assign('type',$type);
            return view('admin/request/add_site');
        }else{
            return view('admin/login/index');
        }
    }
    //处理添加页面
    public function add_manage()
    {
        $name     = input('post.name');
        $site = input('post.site');
        $category = input('post.category');
        $judge = input('post.checked');
        if($name !="" && $site !="" &&$category !=""){
            $data = ['name' => $name, 'site' => $site,'type_id'=>$category,'judge'=>$judge];
            Db::table('admin_audit')->insert($data);
            $this->success('添加成功', 'index/admin/request');
        }else{
            $this->error('对不起,网站名称或者网站地址或者网站类别没有填写');
        }
    }
    //垃圾箱
    public function waste()
    {
        $session = Session::has('name','think');
        if($session ==true) {
            $data = Db::view('admin_audit','id,name,site,judge,state')
                ->view('admin_type','type,state','admin_type.id=admin_audit.type_id')
                ->where('admin_audit.state=1')->order('id desc')->paginate(15);
            $type = Db::table('admin_type')->where('state',1)->select();
            $this->assign('type',$type);
            $this->assign('data', $data);
            return view('admin/waste/index');
        }else{
            return view('admin/login/index');
        }
    }
    //垃圾箱网站恢复
    public function restore_url()
    {
        $session = Session::has('name','think');
        if($session ==true) {
            $id = Request::instance()->param('id');
            $data = db('admin_audit')->where('id', $id)->update(['state' => '0']);

            if($data){
                $this->success('恢复成功', 'index/admin/waste');
            }else {
                $this->error('对不起,恢复失败,请稍后再试');
            }
        }else{
            return view('admin/login/index');
        }
    }
    //垃圾箱分类恢复
    public function restore_grouping()
    {
        $session = Session::has('name','think');
        if($session ==true) {
            $id = Request::instance()->param('id');
            $data = db('admin_type')->where('id', $id)->update(['state' => '0']);

            if($data){
                $this->success('恢复成功', 'index/admin/waste');
            }else {
                $this->error('对不起,恢复失败,请稍后再试');
            }
        }else{
            return view('admin/login/index');
        }
    }
    //安全退出
    public function exit()
    {
        Session::clear('think');
        $this->success('退出成功', 'index/admin/login');
    }
    //获取磁盘大小
    public function disk()
    {
        $_POST['file_name'] = "E:/phpstudy";
        $file_name = iconv("utf-8", "gb2312", $_POST['file_name']);      // 编码格式转换

        if (file_exists($file_name)) {                                  //判断目录是否存在

            $len = strripos($file_name, ":");                            //截取字符串

            $dir = substr($file_name, 0, $len + 1);                        //获取提交目录所在磁盘

            $filesize_z = disk_total_space($dir);                       //获取目录大小

            $filesize_z = number_format($filesize_z / (1024 * 1024 * 1024), 2, ".", "");    //数字的格式化

            $filesize_s = disk_free_space($dir);                            //获取裁判剩余空间

            $filesize_s = number_format($filesize_s / (1024 * 1024 * 1024), 2, ".", ""); //字节的格式化
            $disk =[0=>$filesize_z,1=>$filesize_s];
            $this->assign('disk',$disk);
            return view('admin/disk/index');
        }else{
            $this->success('未获取到磁盘信息,请联系技术人员进行修改', 'admin/index');
        }

    }
}