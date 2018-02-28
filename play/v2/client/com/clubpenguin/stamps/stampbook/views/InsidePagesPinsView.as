class com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView;
   static var LINKAGE_ID = "InsidePagesPinsView";
   static var CONTENT_LIST_CLIP_NAME = "contentList";
   static var ITEM_RENDERER = "BaseItemRenderer";
   static var RENDERER_WIDTH = 55.85;
   static var RENDERER_HEIGHT = 51.9;
   static var LIST_PADDING = 20;
   static var LIST_WIDTH = 560;
   static var LIST_HEIGHT = 340;
   static var DESCRIPTIONBOX_X_OFFSET = 25;
   static var DESCRIPTIONBOX_Y_OFFSET = 7;
   function InsidePagesPinsView()
   {
      super();
      this._filePath = this._shell.getPath("stampbook_categoryHeader");
   }
   function reset()
   {
      this.list.reset();
   }
   function cleanUp()
   {
      this.content_holder_mc[com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.CONTENT_LIST_CLIP_NAME].removeMovieClip();
      this.list.removeEventListener("over",this.onItemRollOver,this);
      this.list.removeEventListener("out",this.onItemRollOut,this);
   }
   function configUI()
   {
      this.pinIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      super.configUI();
   }
   function populateUI()
   {
      this.descriptionBox.__set__singleLine(true);
      if(this.pinLoadMc)
      {
         this.pinLoadMc.removeMovieClip();
      }
      this.pinLoadMc = this.pinIconHolder.attachMovie(com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView.BLANK_CLIP_LINKAGE_ID,"clip",1,{_x:0,_y:0});
      this.pinIconLoader.loadClip(this._filePath + this._model.getID() + ".swf",this.pinLoadMc);
      this.title_txt.text = this._model.getName();
      if(this.list)
      {
         this.list.__set__dataProvider(this._model.getItems());
         return undefined;
      }
      this.list = (com.clubpenguin.stamps.stampbook.controls.List)this.content_holder_mc.attachMovie("ListBrown",com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.CONTENT_LIST_CLIP_NAME,this.content_holder_mc.getNextHighestDepth());
      this.list.addEventListener("over",this.onItemRollOver,this);
      this.list.addEventListener("out",this.onItemRollOut,this);
      this.list.init(com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.LIST_WIDTH,com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.LIST_HEIGHT,com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.ITEM_RENDERER,com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.RENDERER_WIDTH,com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.RENDERER_HEIGHT,com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.LIST_PADDING,false);
      this.list.__set__dataProvider(this._model.getItems());
      this.list.move(0,0);
      this.list.scrollBar._visible = this.list.__get__dataProvider().length > 0;
   }
   function onItemRollOver(event)
   {
      this.descriptionBox._x = event.target._x + com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.DESCRIPTIONBOX_X_OFFSET;
      this.descriptionBox._y = event.target._y + com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView.DESCRIPTIONBOX_Y_OFFSET;
      this.descriptionBox.setModel(event.data);
   }
   function onItemRollOut(event)
   {
      this.descriptionBox._x = -1000;
      this.descriptionBox._y = -1000;
   }
}
