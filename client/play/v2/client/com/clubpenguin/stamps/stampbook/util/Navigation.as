class com.clubpenguin.stamps.stampbook.util.Navigation extends com.clubpenguin.util.EventDispatcher
{
   function Navigation(structure)
   {
      super();
      this._shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
      this.structure = structure;
      this.indexList = [];
      this.update();
   }
   function __get__title()
   {
      if(this.currentSection == this.structure)
      {
         return this._shell.getLocalizedString("contents_category_title");
      }
      return this.currentSection.getName();
   }
   function __get__parentTitle()
   {
      var _loc3_ = this.indexList.length;
      var _loc2_ = this.lookUp(_loc3_ - 1);
      if(_loc2_ == this.structure)
      {
         return this.currentSection.getName();
      }
      return _loc2_.getName();
   }
   function __get__children()
   {
      if(this.currentSection == this.structure)
      {
         return Array(this.currentSection);
      }
      return this.currentSection.getSubCategories();
   }
   function __get__type()
   {
      return null;
   }
   function reset()
   {
      this.indexList = [];
      this.update();
   }
   function next()
   {
      var _loc9_ = this.indexList.slice(0);
      var _loc6_ = false;
      while(true)
      {
         if(this.indexList.length == 0)
         {
            this.indexList.push(0);
            this.update();
            return undefined;
         }
         var _loc2_ = this.indexList.length;
         var _loc8_ = this.lookUp(_loc2_);
         var _loc4_ = _loc8_.getSubCategories();
         if(!_loc6_ && _loc4_ != undefined && _loc4_.length > 0)
         {
            this.indexList.push(0);
            this.update();
            return undefined;
         }
         _loc6_ = false;
         var _loc7_ = this.indexList[_loc2_ - 1];
         var _loc5_ = this.lookUp(_loc2_ - 1);
         var _loc3_ = undefined;
         if(_loc5_ == this.structure)
         {
            _loc3_ = this.structure;
         }
         else
         {
            _loc3_ = _loc5_.getSubCategories();
         }
         if(_loc7_ == _loc3_.length - 1)
         {
            this.indexList.pop();
            _loc6_ = true;
            if(this.indexList.length == 0)
            {
               this.indexList = _loc9_;
               return undefined;
            }
            continue;
         }
         this.indexList[_loc2_ - 1]++;
         this.update();
         break;
      }
   }
   function previous()
   {
      var _loc7_ = this.indexList.slice(0);
      var _loc8_ = false;
      if(this.indexList.length == 0)
      {
         return undefined;
      }
      var _loc4_ = this.indexList.length;
      var _loc5_ = this.indexList[_loc4_ - 1];
      if(_loc5_ == 0)
      {
         this.indexList.pop();
      }
      else
      {
         this.indexList[_loc4_ - 1]--;
         var _loc6_ = this.lookUp(_loc4_);
         var _loc3_ = _loc6_;
         while(_loc3_.getSubCategories() != undefined && _loc3_.getSubCategories().length > 0)
         {
            var _loc2_ = _loc3_.getSubCategories();
            this.indexList.push(_loc2_.length - 1);
            _loc3_ = _loc2_[_loc2_.length - 1];
         }
      }
      this.update();
      return undefined;
   }
   function update()
   {
      this.currentSection = this.lookUp();
      this.dispatchEvent({type:"change"});
   }
   function lookUp(depth)
   {
      if(depth < 0)
      {
         return null;
      }
      if(depth == null)
      {
         depth = this.indexList.length;
      }
      var _loc3_ = this.structure;
      var _loc2_ = 0;
      while(_loc2_ < depth)
      {
         if(_loc3_ == this.structure)
         {
            _loc3_ = _loc3_[this.indexList[_loc2_]];
         }
         else
         {
            _loc3_ = _loc3_.getSubCategories()[this.indexList[_loc2_]];
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   function addSection(id)
   {
      this.indexList.push(id);
      this.update();
   }
   function removeSection()
   {
      this.indexList.pop();
      this.update();
   }
   function goToSection(id)
   {
      this.indexList = [];
      this.indexList.push(id);
      this.update();
   }
}
