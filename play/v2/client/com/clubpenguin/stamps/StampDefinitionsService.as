class com.clubpenguin.stamps.StampDefinitionsService
{
   static var NO_PARENT_GROUP_ID = 0;
   static var INVALID_CATEGORY_ID = -1;
   function StampDefinitionsService(stampManager, stampDefinitionsParsed, webServiceManager)
   {
      this.stampManager = stampManager;
      this.numStamps = 0;
      this.stampDefinitionsParsed = stampDefinitionsParsed;
      this.stampDefinitions = webServiceManager.getServiceData(com.clubpenguin.net.WebServiceType.STAMPS);
      this.polaroidDefinitions = webServiceManager.getServiceData(com.clubpenguin.net.WebServiceType.POLAROIDS);
      var _loc2_ = this.parsePolaroidDefinitions();
      var _loc3_ = this.parseStampDefinitions(_loc2_);
      stampDefinitionsParsed.dispatch(_loc3_,this.numStamps);
   }
   function parsePolaroidDefinitions()
   {
      var _loc11_ = {};
      if(this.polaroidDefinitions != undefined)
      {
         for(var _loc12_ in this.polaroidDefinitions)
         {
            var _loc6_ = this.polaroidDefinitions[_loc12_].polaroids;
            var _loc10_ = _loc6_ != undefined?_loc6_.length:0;
            _loc11_[_loc12_] = [];
            var _loc3_ = 0;
            while(_loc3_ < _loc10_)
            {
               var _loc2_ = _loc6_[_loc3_];
               var _loc5_ = Number(_loc2_.polaroid_id);
               var _loc9_ = Number(_loc2_.stamp_count);
               var _loc4_ = "";
               var _loc8_ = String(_loc2_.description);
               var _loc7_ = new com.clubpenguin.stamps.PolaroidItem(_loc5_,_loc9_,_loc4_,_loc8_);
               _loc11_[_loc12_].push(_loc7_);
               _loc3_ = _loc3_ + 1;
            }
         }
      }
      return _loc11_;
   }
   function parseStampDefinitions(categoryIDsToPolariodItems)
   {
      var _loc27_ = [];
      if(this.stampDefinitions != undefined)
      {
         var _loc20_ = {};
         var _loc16_ = {};
         for(var _loc29_ in this.stampDefinitions)
         {
            var _loc22_ = undefined;
            var _loc9_ = this.stampDefinitions[_loc29_];
            var _loc23_ = Number(_loc9_.parent_group_id);
            var _loc14_ = undefined;
            var _loc18_ = com.clubpenguin.stamps.StampDefinitionsService.INVALID_CATEGORY_ID;
            var _loc7_ = Number(_loc29_);
            var _loc24_ = String(_loc9_.name);
            var _loc11_ = [];
            var _loc25_ = categoryIDsToPolariodItems[_loc29_];
            if(_loc23_ == com.clubpenguin.stamps.StampDefinitionsService.NO_PARENT_GROUP_ID)
            {
               _loc14_ = _loc7_;
            }
            else
            {
               _loc14_ = _loc23_;
               _loc18_ = _loc7_;
            }
            for(var _loc26_ in _loc9_.stamps)
            {
               var _loc2_ = _loc9_.stamps[_loc26_];
               var _loc8_ = Number(_loc26_);
               var _loc12_ = _loc14_;
               var _loc13_ = Number(_loc2_.rank);
               var _loc5_ = String(_loc2_.name);
               var _loc10_ = String(_loc2_.description);
               var _loc4_ = Boolean(_loc2_.is_member);
               var _loc6_ = undefined;
               if(_loc7_ == com.clubpenguin.stamps.StampManager.AWARD_CATEGORY_ID)
               {
                  _loc6_ = new com.clubpenguin.stamps.AwardItem(_loc8_,_loc5_,_loc10_,_loc4_);
               }
               else
               {
                  _loc6_ = new com.clubpenguin.stamps.StampItem(_loc8_,_loc12_,_loc13_,_loc5_,_loc10_,_loc4_);
               }
               _loc11_.push(_loc6_);
               this.numStamps = this.numStamps + 1;
            }
            if(_loc7_ == com.clubpenguin.stamps.StampManager.AWARD_CATEGORY_ID)
            {
               _loc11_.sort(this.stampManager.stampBookItemComparisonByID);
            }
            else
            {
               _loc11_.sort(this.stampManager.stampItemComparisonByDifficultyThenID);
            }
            _loc22_ = new com.clubpenguin.stamps.StampBookCategory(_loc7_,_loc24_,null,_loc11_,_loc25_);
            _loc20_[_loc29_] = _loc22_;
            if(_loc18_ != com.clubpenguin.stamps.StampDefinitionsService.INVALID_CATEGORY_ID)
            {
               var _loc30_ = String(_loc14_);
               if(_loc16_[_loc30_] == undefined)
               {
                  _loc16_[_loc30_] = [];
               }
               _loc16_[_loc30_].push(_loc18_);
            }
            else
            {
               _loc27_.push(_loc22_);
            }
         }
         for(var _loc30_ in _loc16_)
         {
            var _loc19_ = _loc20_[_loc30_];
            var _loc17_ = _loc16_[_loc30_];
            var _loc21_ = _loc17_.length;
            var _loc3_ = 0;
            while(_loc3_ < _loc21_)
            {
               var _loc15_ = _loc20_[String(_loc17_[_loc3_])];
               _loc19_.addSubCategory(_loc15_);
               _loc3_ = _loc3_ + 1;
            }
            _loc19_.getSubCategories().sort(this.stampManager.stampBookCategoryComparisonByID);
         }
      }
      _loc27_.sort(this.stampManager.stampBookCategoryComparisonByID);
      return _loc27_;
   }
}
