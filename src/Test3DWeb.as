package{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import sandy.core.Scene3D;
	import sandy.core.scenegraph.Camera3D;
	import sandy.core.scenegraph.Group;
	import sandy.materials.Appearance;
	import sandy.materials.BitmapMaterial;
	import sandy.materials.ColorMaterial;
	import sandy.materials.Material;
	import sandy.materials.attributes.LightAttributes;
	import sandy.materials.attributes.LineAttributes;
	import sandy.materials.attributes.MaterialAttributes;
	import sandy.primitive.Box;
	import sandy.primitive.Sphere;
	
	public class Test3DWeb extends Sprite
	{
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var box:Box;
		private var sphere:Sphere;
		
		public function Test3DWeb() {
			//创建一个摄像机
			camera = new Camera3D(300, 300);
//			camera.z = -300;
			camera.z = -300;
			
			//创建一个 Group
			var root:Group = new Group();
			
			//添加盒子
//			box = new Box("box", 100, 100, 100, "tri");//mode: tri（三角） quad（平）
//			root.addChild(box);
			
			//添加球体
			sphere = new Sphere("sphere",100,20,20);
			root.addChild(sphere);

			//设置立方体的贴图
			loadImg(function(bd:BitmapData):void{
				var material:BitmapMaterial = new BitmapMaterial( bd );
				var app:Appearance = new Appearance( material );
//				box.appearance = app;
				sphere.appearance = app;
			});
			
			//创建场景
			scene = new Scene3D( "scene", this, camera, root );
			
			//创建实时侦听
			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}
		public function enterFrameHandler(_evt:Event):void {
//			box.rotateX += 4;
//			box.rotateY += 4;
//			box.rotateZ += 4;
//			box.rotateX = -mouseY/2;
//			box.rotateY = mouseX/2;
			
//			sphere.rotateX += 1;
			sphere.rotateY += 0.5;
//			sphere.rotateZ += 1;
//			sphere.rotateX = -mouseX;
//			sphere.rotateY = -mouseY;

			scene.render();
		}
		
		private function loadImg(onComplete:Function):void{
			var loader:Loader=new Loader();
			var onLoadImgComplete:Function=function(evt:Event):void{
				var loaderInfo:LoaderInfo = evt.currentTarget as LoaderInfo;
				var bitmap:Bitmap=loaderInfo.loader.content as Bitmap;
				var bd:BitmapData = bitmap.bitmapData;
				loaderInfo.loader.unload();
				if(onComplete){
					onComplete(bd);
				}
			}
			var onLoadImgProgress:Function=function(evt:ProgressEvent):void{
			}
			var onLoadImgError:Function=function(evt:Event):void{
			}
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadImgProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadImgComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoadImgError);
			var rq:URLRequest=new URLRequest("image/006549905198527cbce56d05db0e0bd5.jpg");
			loader.load(rq);
		}
	}
}