class com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView;
   static var LINKAGE_ID = "InsidePagesSubContentView";
   static var CONTENT_LIST_CLIP_NAME = "contentList";
   static var ITEM_RENDERER = "ListButton";
   static var RENDERER_WIDTH = 164;
   static var RENDERER_HEIGHT = 30;
   static var LIST_PADDING = 15;
   static var LIST_WIDTH = 545;
   static var LIST_HEIGHT = 225;
   function InsidePagesSubContentView()
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
      this.content_holder_mc[com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.CONTENT_LIST_CLIP_NAME].removeMovieClip();
      this.list.removeEventListener("itemClick",this.onListItemClick,this);
   }
   function configUI()
   {
      this.stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
      super.configUI();
   }
   function populateUI()
   {
      if(this.load_mc)
      {
         this.load_mc.removeMovieClip();
      }
      this.load_mc = this.stampIconHolder.attachMovie(com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView.BLANK_CLIP_LINKAGE_ID,"clip",1,{_x:0,_y:0});
      this.stampIconLoader.loadClip(this._filePath + this._model.getID() + ".swf",this.load_mc);
      this.title_txt.text = this._model.getName();
      if(this.list)
      {
         this.list.__set__dataProvider(this._model.getSubCategories());
         return undefined;
      }
      this.list = (com.clubpenguin.stamps.stampbook.controls.ContentList)this.content_holder_mc.attachMovie("ContentList",com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.CONTENT_LIST_CLIP_NAME,this.content_holder_mc.getNextHighestDepth());
      this.list.init(com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.LIST_WIDTH,com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.LIST_HEIGHT,com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.ITEM_RENDERER,com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.RENDERER_WIDTH,com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.RENDERER_HEIGHT,com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView.LIST_PADDING);
      this.list.addEventListener("itemClick",this.onListItemClick,this);
      this.list.__set__dataProvider(this._model.getSubCategories());
      this.list.move(0,0);
   }
   function onListItemClick(event)
   {
      this.dispatchEvent(event);
   }
}
