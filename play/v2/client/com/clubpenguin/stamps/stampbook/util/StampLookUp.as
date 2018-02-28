class com.clubpenguin.stamps.stampbook.util.StampLookUp extends MovieClip
{
   static var CLASS_REF = com.clubpenguin.stamps.stampbook.util.StampLookUp;
   static var LINKAGE_ID = "StampLookUp";
   static var USER_STAMPS = "userStamps";
   static var TOTAL_STAMPS = "totalStamps";
   static var USER_NONCOVER_STAMPS = "userNoncoverStamps";
   function StampLookUp()
   {
      super();
   }
   function initialize(userObject, masterList, userStamps, coverStamps, stampManager)
   {
      this._userObject = userObject;
      this._masterList = masterList;
      this._userStamps = userStamps;
      this._coverStamps = coverStamps;
      this._stampManager = stampManager;
      this._userStampsHash = {};
      this._coverStampsHash = {};
      this._selectedCategoryHash = {};
      this._stampsHash = {};
      var _loc16_ = this._userStamps.length;
      var _loc7_ = 0;
      while(_loc7_ < _loc16_)
      {
         this._userStampsHash[this._userStamps[_loc7_].getID()] = true;
         _loc7_ = _loc7_ + 1;
      }
      var _loc13_ = this._coverStamps.getCoverItems();
      var _loc14_ = _loc13_.length;
      _loc7_ = 0;
      while(_loc7_ < _loc14_)
      {
         var _loc12_ = _loc13_[_loc7_].getItem();
         this._coverStampsHash[_loc12_.getID()] = true;
         _loc7_ = _loc7_ + 1;
      }
      var _loc20_ = undefined;
      var _loc17_ = undefined;
      this._pageList = [];
      var _loc15_ = this._masterList.length;
      _loc7_ = 0;
      while(_loc7_ < _loc15_)
      {
         var _loc5_ = this._masterList[_loc7_].getSubCategories();
         if(_loc5_ != undefined && _loc5_.length > 0)
         {
            var _loc10_ = _loc5_.length;
            this._pageList.push(this._masterList[_loc7_]);
            var _loc3_ = 0;
            while(_loc3_ < _loc10_)
            {
               this._pageList.push(_loc5_[_loc3_]);
               var _loc6_ = _loc5_[_loc3_].getItems();
               var _loc8_ = _loc6_.length;
               var _loc4_ = 0;
               while(_loc4_ < _loc8_)
               {
                  var _loc2_ = _loc6_[_loc4_];
                  this._stampsHash[_loc2_.getID()] = _loc2_;
                  _loc4_ = _loc4_ + 1;
               }
               _loc3_ = _loc3_ + 1;
            }
         }
         else
         {
            this._pageList.push(this._masterList[_loc7_]);
            var _loc9_ = this._masterList[_loc7_].getItems();
            var _loc11_ = _loc9_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc11_)
            {
               _loc2_ = _loc9_[_loc4_];
               this._stampsHash[_loc2_.getID()] = _loc2_;
               _loc4_ = _loc4_ + 1;
            }
         }
         _loc7_ = _loc7_ + 1;
      }
   }
   function isOwned(id)
   {
      return this._userStampsHash[id];
   }
   function isCover(id)
   {
      return this._coverStampsHash[id];
   }
   function removeStampFromCover(id)
   {
      this._coverStampsHash[id] = false;
   }
   function addStampToCover(id)
   {
      this._coverStampsHash[id] = true;
   }
   function setCategorySelected(categoryID)
   {
      for(var _loc2_ in this._selectedCategoryHash)
      {
         this._selectedCategoryHash[_loc2_] = false;
      }
      this._selectedCategoryHash[categoryID] = true;
   }
   function isCategorySelected(categoryID)
   {
      if(this._selectedCategoryHash[categoryID] != undefined)
      {
         return this._selectedCategoryHash[categoryID];
      }
      return false;
   }
   function getStampByID(stampID)
   {
      return this._stampsHash[stampID];
   }
   function addStampsForSection(section, flag)
   {
      var _loc2_ = undefined;
      var _loc3_ = section.length;
      if(_loc3_)
      {
         var _loc4_ = Array(section);
         _loc2_ = this.addStamps(_loc4_[0],flag);
      }
      else
      {
         var _loc5_ = [section];
         _loc2_ = this.addStamps(_loc5_,flag);
      }
      return _loc2_;
   }
   function addStamps(section, flag)
   {
      var _loc4_ = [];
      var _loc11_ = section.length;
      var _loc9_ = com.clubpenguin.stamps.StampManager.PIN_CATEGORY_ID;
      var _loc6_ = 0;
      while(_loc6_ < _loc11_)
      {
         var _loc5_ = section[_loc6_];
         if(_loc5_.getID() == _loc9_)
         {
            if(flag != com.clubpenguin.stamps.stampbook.util.StampLookUp.USER_NONCOVER_STAMPS)
            {
            }
            addr204:
            _loc6_ = _loc6_ + 1;
            continue;
         }
         var _loc10_ = _loc5_.getSubCategories();
         _loc4_ = _loc4_.concat(this.addStamps(_loc10_,flag));
         var _loc3_ = _loc5_.getItems();
         var _loc8_ = _loc3_.length;
         var _loc2_ = 0;
         while(_loc2_ < _loc8_)
         {
            switch(flag)
            {
               case com.clubpenguin.stamps.stampbook.util.StampLookUp.USER_STAMPS:
                  if(this.isOwned(_loc3_[_loc2_].getID()))
                  {
                     _loc4_.push(_loc3_[_loc2_]);
                  }
                  break;
               case com.clubpenguin.stamps.stampbook.util.StampLookUp.TOTAL_STAMPS:
                  _loc4_.push(_loc3_[_loc2_]);
                  break;
               case com.clubpenguin.stamps.stampbook.util.StampLookUp.USER_NONCOVER_STAMPS:
                  if(_loc5_.getID() == _loc9_)
                  {
                     if(!this.isCover(_loc3_[_loc2_].getID()))
                     {
                        _loc4_.push(_loc3_[_loc2_]);
                     }
                  }
                  else if(this.isOwned(_loc3_[_loc2_].getID()) && !this.isCover(_loc3_[_loc2_].getID()))
                  {
                     _loc4_.push(_loc3_[_loc2_]);
                  }
            }
            _loc2_ = _loc2_ + 1;
         }
         §§goto(addr204);
      }
      return _loc4_;
   }
   function getStampsForCategory(section)
   {
      return this.addStampsForSection(section,com.clubpenguin.stamps.stampbook.util.StampLookUp.USER_NONCOVER_STAMPS);
   }
   function getNumberOfTotalStampsForCategory(section)
   {
      var _loc2_ = this.addStampsForSection(section,com.clubpenguin.stamps.stampbook.util.StampLookUp.TOTAL_STAMPS);
      return _loc2_.length;
   }
   function getNumberOfUserStampsForCategory(section)
   {
      var _loc2_ = this.addStampsForSection(section,com.clubpenguin.stamps.stampbook.util.StampLookUp.USER_STAMPS);
      return _loc2_.length;
   }
   function getNumberOfUserStamps()
   {
      return this._userStamps.length;
   }
   function getPageList()
   {
      return this._pageList;
   }
   function getMasterList()
   {
      return this._masterList;
   }
   function getPlayerNickname()
   {
      return this._userObject.nickname;
   }
   static function getInstance()
   {
      if(com.clubpenguin.stamps.stampbook.util.StampLookUp._instance == null)
      {
         com.clubpenguin.stamps.stampbook.util.StampLookUp._instance = new com.clubpenguin.stamps.stampbook.util.StampLookUp();
      }
      return com.clubpenguin.stamps.stampbook.util.StampLookUp._instance;
   }
}
