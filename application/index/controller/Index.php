<?php
namespace app\index\controller;
use think\Db;
use think\Controller;
use \think\Request;
class Index extends Controller
{
    public function home()
    {
        $data = Db::view('admin_audit','id,name,site,judge,type_id')
            ->view('admin_type','id,type,state','admin_type.id=admin_audit.type_id')
            ->where('admin_audit.judge=0')->where('admin_type.state=0')->select();
        $this->assign('data', $data);
        $type = Db::table('admin_type')->where('state','0')->select();
        $request = Request::instance();
        $request = $request->domain();
        print_r($request);
        $this->assign('request',$request);
        $this->assign('type',$type);
        $this->assign('data',$data);
        return view('index/home');
    }
    //搜索
    public function search()
    {
        $import = input('post.import');
        if($import){
            $data = Db::view('admin_audit','id,name,site,judge,type_id')
                ->view('admin_type','id,type,state','admin_type.id=admin_audit.type_id')
                ->where('admin_audit.judge=0')->where('admin_type.state=0')->where('admin_audit.name','like','%'.$import.'%')->select();
            if($data) {
                $this->assign('data',$data);
                return view('index/search/index');
            }else {
                $this->error('Sorry, I can\'t find the category of website you want to inquire');
            }
        }else{
            $this->error('Sorry, you did not enter the site category you are looking for');
        }
    }
    //分类
    public function classify()
    {
        $type = Request::instance()->param('type');
        if($type){
            $data = Db::view('admin_audit','id,name,site,judge,type_id')
                ->view('admin_type','id,type,state','admin_type.id=admin_audit.type_id')
                ->where('admin_audit.judge=0')->where('admin_type.state=0')->where('admin_type.type',$type)->select();
            if($data) {
                $this->assign('data',$data);
                return view('index/search/index');

            }else {
                $this->error('Sorry, this classification has no information at the moment');
            }
        }else{
            $this->error('Sorry, the classification is not available at the moment');
        }
    }
    //用户添加网站页面
    public function add_site()
    {
        $type = Db::table('admin_type')->where('state',0)->select();
        $this->assign('type',$type);
        return view('index/add_site/index');
    }
    //提交申请
    public function audit()
    {
        $name     =input('post.name');
        $site     =input('post.site');
        $category = input('post.category');
        if($name !="" &&$site !="" &&$category !=""){
            if (strpos($site,'https')!== false ||strpos($site,'http')!== false) {
                $data = ['name' => $name, 'site' => $site, 'type_id' => $category, 'judge' => '1','state'=>'0'];
                db('admin_audit')->insert($data);
                $this->success('Submission is successful and under review', 'index/index/home');
            }else{
                $site ="http://".$site;
                $data = ['name' => $name, 'site' => $site, 'type_id' => $category, 'judge' => '1','state'=>'0'];
                db('admin_audit')->insert($data);
                $this->success('Submission is successful and under review', 'index/index/home');
            }
        }else{
            $this->error('Sorry, your website name, website address or website type is not filled in completely');
        }
    }
    //联系我们
    public function contact()
    {
        return view('index/contact/index');
    }
}
