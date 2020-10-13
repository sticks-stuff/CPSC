class com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView;
   static var LINKAGE_ID = "InsidePagesStampsView";
   static var CONTENT_LIST_CLIP_NAME = "contentList";
   static var ITEM_RENDERER = "StampsRenderer";
   static var RENDERER_WIDTH = 58;
   static var RENDERER_HEIGHT = 54;
   static var LIST_PADDING = 30;
   static var LIST_WIDTH = 365;
   static var LIST_HEIGHT = 360;
   static var DESCRIPTIONBOX_X_OFFSET = 20;
   static var DESCRIPTIONBOX_Y_OFFSET = -5;
   function InsidePagesStampsView()
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
      this.content_holder_mc[com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.CONTENT_LIST_CLIP_NAME].removeMovieClip();
      this.list.removeEventListener("over",this.onItemRollOver,this);
      this.list.removeEventListener("out",this.onItemRollOut,this);
   }
   function configUI()
   {
      this.stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      super.configUI();
   }
   function populateUI()
   {
      if(this.stampIconHolder.load_mc)
      {
         this.stampIconHolder.load_mc.removeMovieClip();
      }
      this.stampIconHolder.createEmptyMovieClip("load_mc",1);
      this.stampIconLoader.loadClip(this._filePath + this._model.getID() + ".swf",this.stampIconHolder.load_mc);
      this.title_txt.text = this._model.getName();
      if(this.polaroidsPanel)
      {
         this.polaroidsPanel.removeMovieClip();
      }
      this.attachMovie("PolaroidsPanel","polaroidsPanel",1,{_x:463,_y:98});
      this.polaroidsPanel.setModel(this._model);
      if(this.list)
      {
         this.list.__set__dataProvider(this._model.getItems());
         return undefined;
      }
      this.list = (com.clubpenguin.stamps.stampbook.controls.List)this.content_holder_mc.attachMovie("ListBrown",com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.CONTENT_LIST_CLIP_NAME,this.content_holder_mc.getNextHighestDepth());
      this.list.addEventListener("over",this.onItemRollOver,this);
      this.list.addEventListener("out",this.onItemRollOut,this);
      this.list.init(com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.LIST_WIDTH,com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.LIST_HEIGHT,com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.ITEM_RENDERER,com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.RENDERER_WIDTH,com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.RENDERER_HEIGHT,com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.LIST_PADDING,true);
      this.list.__set__dataProvider(this._model.getItems());
      this.list.move(0,0);
   }
   function onItemRollOver(event)
   {
      this.descriptionBox._x = event.target._x + com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.DESCRIPTIONBOX_X_OFFSET;
      this.descriptionBox._y = event.target._y + com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView.DESCRIPTIONBOX_Y_OFFSET;
      this.descriptionBox.setModel(event.data);
   }
   function onItemRollOut(event)
   {
      this.descriptionBox._x = -1000;
      this.descriptionBox._y = -1000;
   }
}
